/**
 *Submitted for verification at Etherscan.io on 2023-02-28
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BWS_DatabaseMutableV1 {
  
    // These will be assigned at the construction
    // phase, where `msg.sender` is the account
    // creating this contract.
    address private immutable owner;
    
    // bytes32 "table" definition
    struct bytes32Column {
        bool created;
        bytes32 value;
    }
    mapping (bytes32 => mapping(bytes32 => bytes32Column)) public myBytes32Table;

     // string "table" definition
    struct stringColumn {
        bool created;
        string value;
    }
    mapping (bytes32 => mapping(bytes32 => stringColumn)) public myStringTable;

    // events
    event LogOwner (address indexed owner);

    // exceptions
    error Unauthorized();
    error NoData();
    error RowKeyInUse();

    constructor() {
        owner = msg.sender;
        emit LogOwner(msg.sender);
    }

    modifier onlyBy(address _account)
    {
        if (msg.sender != _account)
            revert Unauthorized();
        // Do not forget the "_;"! It will
        // be replaced by the actual function
        // body when the modifier is used.
        _;
    }

    // identity represents the "user" that owns the "database"
    // and is (for now) generated and stored by Blockchain Web Services.
    function insertBytes32(bytes32 identity, bytes32 key, bytes32 data)
        public
        onlyBy(owner)
    {     
        myBytes32Table[identity][key].created = true;
        myBytes32Table[identity][key].value = data;
    }

    function selectBytes32(bytes32 identity, bytes32 key)
        public view 
        onlyBy(owner)
        returns (bytes32)
    {
        if (!myBytes32Table[identity][key].created)
          revert NoData();     
        return myBytes32Table[identity][key].value; 
    }

    // identity represents the "user" that owns the "database"
    // and is (for now) generated and stored by Blockchain Web Services.
    function insertString(bytes32 identity, bytes32 key, string memory data)
        public
        onlyBy(owner)
    { 
      myStringTable[identity][key].created = true;
      myStringTable[identity][key].value = data;
    }

    function selectString(bytes32 identity,  bytes32 key)
        public view 
        onlyBy(owner)
        returns (string memory)
    {
        if (!myStringTable[identity][key].created)
          revert NoData();     
        return myStringTable[identity][key].value; 
    }

}