// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract CharityTracking {
    address public owner;
    string[] public descriptions;
    uint totaldonations;

    constructor() {
        owner = msg.sender;
    }

    mapping(address => uint) balance;
    mapping(string => uint) Spending;

    modifier onlyowner() {
        require(msg.sender == owner, "Only the owner can perform this operation");
        _;
    }

    function donate(uint amount) payable public {
        require(amount > 0, "Amount should be greater than zero");
        totaldonations += amount;
        balance[msg.sender] += amount;


        assert(totaldonations >= amount); 
    }

    function checkbalance() public view returns (uint) {
        return totaldonations;
    }

    function withdraw(uint amount) onlyowner() public payable {

        if (amount > balance[msg.sender]) {
            revert("Amount exceeds balance");
        }

        balance[msg.sender] -= amount;

        
        assert(balance[msg.sender] >= 0); 
    }
}
