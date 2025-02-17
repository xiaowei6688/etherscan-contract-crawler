// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "Ownable.sol";
import "IChainlinkFredRelease.sol";
import "IChainlinkFredObservation.sol";
import "DateTimeMath.sol";
import "StringUtils.sol";


/**
 * @title PredictIndex
 * @author Geminon Protocol
 * @notice This contract performs the calculations for the prediction of the 
 * CPI time series using the Holt Winters method. It makes requests to the oracle 
 * contract that downloads the data from the API for the last value of the series 
 * (observation) and the date of the next releases of the data, then makes the 
 * prediction of the next two values of the CPI series. If the next release 
 * date is exceeded and target has not been updated, it provides the value of the second 
 * prediction when is queried. If the value of the second date is exceeded without updating 
 * the value of the series, it stops providing data (calls to get methods revert).
 * @dev CPI observations, smoothed series derived from those observations, and
 * predictions use 3 decimals. Target values derived from those series are calculated
 * with higher precision, 6 decimals since they are relative numbers expected to be
 * around 1. 
 */
contract PredictIndex is Ownable, DateTimeMath, StringUtils {
    
    IChainlinkFredRelease private releaseAPI;
    IChainlinkFredObservation private observationAPI;

    bool public isInitialized;
    
    uint32 public baseValue;
    uint16 public baseYear;
    uint8 public baseMonth;

    uint8 public releaseHour;
    uint8 public releaseMinute;
    
    uint16 private alpha;
    uint16 private gamma;
    uint32 private smooth;
    uint32 private trend;

    uint64 public targetValue;
    uint64 public backupValue;
    uint64 public targetTimestamp;
    uint64 public backupTimestamp;

    address public backupProvider;
    
    /// @dev Values stored to allow external checks of the internal state.
    /// The contract just need to store the last observation to work.
    uint32[] public CPIValues;
    mapping(uint16 => mapping(uint8 => uint32)) public CPIObservations;
    
    
    struct CPIobservation {
        uint16 year;
        uint8 month;
        uint32 observation;
    }
    
    struct releaseDate {
        uint16 year;
        uint8 month;
        uint8 day;
    }
    
    releaseDate public lastReleaseDate;
    CPIobservation private lastObservation;
    
    
    modifier whenInitialized() {
        require(isInitialized);
        _;
    }
    
    modifier whenNotInitialized() {
        require(!isInitialized);
        _;
    }

    modifier whenNotOutdated() {
        require(block.timestamp < backupTimestamp, "[PredictIndex]: Observations outdated");
        _;
    }

    modifier onlyValidProvider() {
        require(msg.sender == owner() || msg.sender == backupProvider);
        _;
    }


    constructor (address _releaseAPI, address _observationAPI) {
        releaseAPI = IChainlinkFredRelease(_releaseAPI);
        observationAPI = IChainlinkFredObservation(_observationAPI);
        isInitialized = false;
    }


    /// @notice This function is used to provide initial values of the CPI series needed to 
    /// adjust the prediction model.
    /// @dev Observations must be pased with 1e6 conversion for decimals. Initialize values is
    /// not enough to make the contract work: provideData method must be called after this.
    /// @param years_ Array with the years of the observations
    /// @param months_ Array with the number of the months of the observations (1=Jan, 12=Dec)
    /// @param observations Array with the values of the CPI observations multiplied by 10**3
    /// @param release Date when the next CPI data will be released
    /// @param hourRel Hour of the day when the CPI data is released (UTC) [0,23]
    /// @param minuteRel Minute when the CPI data is released [0,59]
    /// @param span Number of periods of the SMA equivalent smooth
    /// @param t_span Number of periods of the SMA equivalent smooth for the trend component
    /// @param baseYear_ Year of the base CPI value to calculate the peg
    /// @param baseMonth_ Number of the month of the base CPI value
    function initializeSeries(
        uint16[] memory years_, 
        uint8[] memory months_, 
        uint32[] memory observations, 
        releaseDate memory release,
        uint8 hourRel, 
        uint8 minuteRel,
        uint16 span,
        uint16 t_span,
        uint16 baseYear_,
        uint8 baseMonth_
    ) 
        external onlyOwner whenNotInitialized 
    {
        require(years_.length == months_.length); // dev: length years vs months
        require(years_.length == observations.length); // dev: length years vs obs
        require(observations.length >= 24); // dev: length obs
        require(release.year >= 2022); // dev: release year
        require(release.month >= 1); // dev: min release month
        require(release.month <= 12); // dev: max release month
        require(release.day >= 1); // dev: min release day
        require(release.day <= 31); // dev: max release day
        require(hourRel < 24); // dev: hour rel
        require(minuteRel < 60); // dev: minute rel
        require(span > 0); // dev: span
        require(t_span > 0); // dev: t span

        uint256 l = observations.length;
        for (uint16 i=0; i < l-1; i++) {
            CPIValues.push(observations[i]);
            CPIObservations[years_[i]][months_[i]] = observations[i];
        }

        baseYear = baseYear_;
        baseMonth = baseMonth_;
        baseValue = CPIObservations[baseYear][baseMonth];
        require(baseValue != 0); // dev: base value 0

        alpha = (2*1e3) / (1+span);
        gamma = (2*1e3) / (1+t_span);

        (smooth, trend) = _applyESAT(observations, alpha, gamma);

        setNewReleaseTime(hourRel, minuteRel);
        
        CPIobservation memory observation = CPIobservation(years_[l-1], months_[l-1], observations[l-1]);
        _updateData(release, observation);
        
        isInitialized = true;
    }

    
    /// @dev Owner can add an address that can provide backup CPI data to the contract
    function addDataProvider(address newProvider) external onlyOwner {
        backupProvider = newProvider;
    }

    /// @dev Owner can remove the address that provides backup CPI data to the contract
    function removeDataProvider() external onlyOwner {
        backupProvider = address(0);
    }

    /// @dev Owner can set the API connectors
    function setAPIConnectors(address _releaseAPI, address _observationAPI) external onlyOwner {
        releaseAPI = IChainlinkFredRelease(_releaseAPI);
        observationAPI = IChainlinkFredObservation(_observationAPI);
    }

    /// @dev Owner can set the UTC time of the CPI data release
    function setNewReleaseTime(uint8 hour, uint8 minute) public onlyOwner {
        releaseHour = hour;
        releaseMinute = minute;
    }

    /// @notice Makes an API call through Chainlink node to retrieve CPI data.
    /// This function can be called by anyone who paid the LINK fees to the API
    /// consumer contracts.
    function requestData(string memory apk) external whenInitialized {
        require(releaseAPI.hasPaidFee(msg.sender));
        require(observationAPI.hasPaidFee(msg.sender));

        string memory releaseURL = _makeReleaseUrl(apk);
        string memory observationURL = _makeObservationUrl(apk);

        releaseAPI.makeMultipleRequest(releaseURL);
        observationAPI.makeMultipleRequest(observationURL);
    }

    /// @notice Triggers the update of the smart contract. This is the main access point to use this contract.
    /// @dev Does not require(updatePending) in case the request has been already made by someone else.
    /// getLastReleaseDate() and getLastObservation() can revert if their values are not updated.
    /// Observation retrieved from API has 18 decimals. We need to remove 15 decimals since we use just 3. 
    function fetchData() external whenInitialized {
        (uint16 yearRel, uint8 monthRel, uint8 dayRel) = releaseAPI.getLastReleaseDate();
        (uint16 yearObs, uint8 monthObs, uint256 cpiValue) = observationAPI.getLastObservation();

        releaseDate memory release = releaseDate(yearRel, monthRel, dayRel);
        CPIobservation memory observation = CPIobservation(yearObs, monthObs, _toUint32(cpiValue / 1e15));
        
        _updateData(release, observation);
    }

    /// @notice allows to provide data manually in case oracle does not work. Alternative to fetchData.
    /// @param yearRel Year of the next release of CPI data
    /// @param monthRel Number of the month of the next release of CPI data [1,12]
    /// @param dayRel Day of the month of the next release of CPI data [1,31]
    /// @param yearObs Year of the CPI observation provided
    /// @param monthObs Number of the month of the CPI observation provided [1,12]. The month of the
    /// observation is the previous month of the release.
    /// @param cpiValue Value of the CPI observation with 3 decimal digits (*1e3).
    function provideData(
        uint16 yearRel, 
        uint8 monthRel, 
        uint8 dayRel, 
        uint16 yearObs, 
        uint8 monthObs, 
        uint32 cpiValue
    ) 
        external onlyValidProvider whenInitialized 
    {    
        releaseDate memory release = releaseDate(yearRel, monthRel, dayRel);
        CPIobservation memory observation = CPIobservation(yearObs, monthObs, cpiValue);
        _updateData(release, observation);
    }
    
    /// @notice Shows if the target values provided by the contract can be used
    /// or are outdated. 
    /// @dev It counts the backup (2 step ahead prediction) values as valid 
    /// values, so if it is queried just before it updates the new API value
    /// it still works.
    function isUpdated() public view returns(bool) {
        return block.timestamp < backupTimestamp;
    }

    /// @notice Returns the last value of the CPI prediction. If the last prediction has expired
    /// it returns the backup value, a 2-step-ahead prediction.
    /// @dev Reverts if values are not initialized or updated
    function getTargetValue() public view whenInitialized whenNotOutdated returns(uint64) {
        if (block.timestamp < targetTimestamp) return targetValue;
        else return backupValue;
    }

    /// @notice Returns the timestamp of the date of the next release of the CPI data. 
    /// @dev Reverts if values are not initialized or updated
    function getTargetTimestamp() public view whenInitialized whenNotOutdated returns(uint64) {
        if (block.timestamp < targetTimestamp) return targetTimestamp;
        else return backupTimestamp;
    }

    /// @dev Get trend value relative to smooth value.
    function getRelativeTrend() public view  whenInitialized whenNotOutdated returns(uint32) {
        return _toUint32((uint64(trend) * 1e6) / smooth);
    }
    

    /// @dev Updates time series of observations with the next value. It allows providing outdated
    /// values, but the status of the isUpdated() method won't change. This is the expected behavior
    /// to allow the contract recovery in case it gets outdated. In this situation, all the missing
    /// observations must be provided in order until the time series are fully updated. 
    function _updateData(releaseDate memory release, CPIobservation memory observation) private {    
        require(observation.month > lastObservation.month || observation.year > lastObservation.year, "Old observation");
        require(release.month > lastReleaseDate.month || release.year > lastReleaseDate.year, "Old release");
        
        CPIValues.push(observation.observation);
        CPIObservations[observation.year][observation.month] = observation.observation;
        lastObservation = observation;
        lastReleaseDate = release;

        _updateTarget();
    }

    /// @dev Updates the prediction of the new target value of the series and the backup values.
    function _updateTarget() private {
        (smooth, trend) = _updateESAT(
            int32(lastObservation.observation), 
            int32(smooth), 
            int32(trend), 
            int16(alpha), 
            int16(gamma)
        );
        if (trend < 0) trend = 0;

        uint256 predictedCPI = _predict(smooth, trend, 1);
        targetValue = _toUint64((predictedCPI * 1e6) / baseValue);
        
        predictedCPI = _predict(smooth, trend, 2);
        backupValue = _toUint64((predictedCPI * 1e6) / baseValue);

        targetTimestamp = _toUint64(
            timestampFromDateTime(
                lastReleaseDate.year, 
                lastReleaseDate.month, 
                lastReleaseDate.day, 
                releaseHour, 
                releaseMinute, 
                0
            )
        );
        backupTimestamp = targetTimestamp + 31 days;
    }

    /// @dev Make the URL of the GET request for the next-release-of-CPI-data API call
    function _makeReleaseUrl(string memory apk) private view returns(string memory) {
        string memory dateTomorrow = _timestampToStrDate(block.timestamp + SECONDS_PER_DAY);
        
        string memory base = 
            'https://api.stlouisfed.org/fred/release/dates?release_id=10&file_type=json&include_release_dates_with_no_data=true';
        string memory apiKey = string.concat('&api_key=', apk);
        string memory dateFrom = string.concat('&realtime_start=', dateTomorrow);

        return string.concat(base, apiKey, dateFrom);
    }

    /// @dev Make the URL of the GET request for the CPI-observations API call
    function _makeObservationUrl(string memory apk) private view returns(string memory) {
        string memory dateToday = _timestampToStrDate(block.timestamp + SECONDS_PER_DAY);
        
        string memory base = 
            'https://api.stlouisfed.org/fred/series/observations?series_id=CPIAUCSL&file_type=json';
        string memory apiKey = string.concat('&api_key=', apk);
        string memory dateFrom = string.concat('&observation_start=', dateToday);

        return string.concat(base, apiKey, dateFrom);
    }

    /// @dev Apply exponential smoothing with additive trend with parameters 
    /// alpha, gamma to a time series Y and returns the last value of the 
    /// smoothed and trend series.
    /// @param Y Time series. 3 decimals (*1e3)
    /// @param _alpha Exponential smoothing parameter. 3 decimals (*1e3)
    /// @param _gamma Trend exponential smoothing parameter. 3 decimals (*1e3)
    function _applyESAT(uint32[] memory Y, uint16 _alpha, uint16 _gamma) 
        private
        pure 
        returns(uint32, uint32) 
    {
        uint16 l = uint16(Y.length);
        uint32[] memory S = new uint32[](l);
        uint32[] memory T = new uint32[](l);
        
        S[0] = Y[0];
        if (Y[l-1] > Y[0]) T[0] = (Y[l-1] - Y[0]) / l;
        else T[0] = 0;

        uint16 t;
        for(t=1; t < l; t++) {
            (S[t], T[t]) = _updateESAT(
                int32(Y[t]), 
                int32(S[t-1]), 
                int32(T[t-1]), 
                int16(_alpha), 
                int16(_gamma)
            );
        }
        
        return (S[t-1], T[t-1]);
    }

    /// @dev Performs one step of exponential smoothing with additive trend
    /// and returns the next values for smoothing and trend.
    /// @param y Last observation of the time series. 3 decimals (*1e3)
    /// @param sPrev Previous value of the smoothing. 3 decimals (*1e3)
    /// @param tPrev Previous value of the trend. 3 decimals (*1e3)
    /// @param _alpha Exponential smoothing parameter. 3 decimals (*1e3)
    /// @param _gamma Trend exponential smoothing parameter. 3 decimals (*1e3)
    /// @return s Smoothed value of the time series. 3 decimals (*1e3)
    /// @return t Smoothed value of the trend. 3 decimals (*1e3)
    function _updateESAT(
        int64 y, 
        int64 sPrev, 
        int64 tPrev, 
        int16 _alpha, 
        int16 _gamma
    ) 
        private pure returns (uint32, uint32) 
    {
        int64 s = (_alpha*y + (1e3-_alpha)*(sPrev+tPrev)) / 1e3;
        int64 t = (_gamma*(s-sPrev) + (1e3-_gamma)*tPrev) / 1e3;
        if (t < 0) 
            t = 0;
        return (uint32(_toInt32(s)), uint32(_toInt32(t)));
    }

    /// @dev n-steps ahead forecast of the time series
    /// @param S last value of the smoothed time series. 3 decimals (*1e3)
    /// @param T last value of the trend. 3 decimals (*1e3)
    /// @param periods number of the time step ahead to predict. Integer without decimals.
    function _predict(uint32 S, uint32 T, uint8 periods) private pure returns(uint32) {
        return S + periods*T;
    }

    /// @dev Transform a timestamp (seconds since 01-01-1970) to a string with format year-month-day
    function _timestampToStrDate(uint256 timestamp) private pure returns (string memory date) {
        (uint256 year, uint256 month, uint256 day) = _daysToDate(timestamp / SECONDS_PER_DAY);
        string memory strmonth = month < 10 ? string.concat('0',uintToString(month)) : uintToString(month);
        string memory strday = day < 10 ? string.concat('0',uintToString(day)) : uintToString(day);

        return string.concat(uintToString(year),'-', strmonth,'-', strday);
    }

    /// @dev safe casting of integer to avoid overflow
    function _toUint32(uint256 value) private pure returns (uint32) {
        require(value <= type(uint32).max);
        return uint32(value);
    }
    /// @dev safe casting of integer to avoid overflow
    function _toUint64(uint256 value) private pure returns (uint64) {
        require(value <= type(uint64).max);
        return uint64(value);
    }
    /// @dev safe casting of integer to avoid overflow
    function _toInt32(int256 value) private pure returns (int32 downcasted) {
        downcasted = int32(value);
        require(downcasted == value);
    }
}