## Use of Error Handling By require(),assert(),revert()

## Overview
The **CharityTracking** smart contract is designed to manage donations and track balances in a decentralized manner. It allows users to donate funds to the contract and the owner to withdraw funds. The contract ensures security and transparency using Solidity's built-in features like `require`, `assert`, and `revert`.

## Features
- **Donation Functionality**: Users can donate ETH to the contract.
- **Owner Privileges**: Only the contract owner can withdraw donations.
- **Balance Tracking**: Total donations and user-specific balances are tracked.
- **Safety Checks**: The contract uses assertions and conditions to ensure safe transfers.

## Contract Details

## Error Handling
- **`require`** is used to validate inputs and ensure that certain conditions are met before proceeding with the logic (e.g., valid donation amounts, restricting access to the owner).
- **`revert`** is used to manually trigger an error when a specific condition is not satisfied, especially in more complex checks like withdrawal limits.
- **`assert`** is used to confirm internal contract invariants, ensuring that critical conditions (like balances) are always in a valid state.


### State Variables
- `address public owner`: The address of the contract owner.
- `string[] public descriptions`: A placeholder array for potential descriptions of donations.
- `uint totaldonations`: Tracks the total amount of donations received by the contract.
- `mapping(address => uint) balance`: A mapping to store the balance of each donor.
- `mapping(string => uint) Spending`: A placeholder mapping for potential spending tracking.

### Modifiers
- `onlyowner`: Restricts access to functions so that only the owner can call them.

### Functions

#### `constructor()`
- Initializes the contract and sets the `owner` to the deployer's address.

#### `donate(uint amount) payable`
- Allows users to donate ETH to the contract.
- Increases the total donation amount and updates the balance for the sender.
- Checks that the donated amount is greater than zero using `require`.
- Uses `assert` to ensure that the total donations have increased correctly.

#### `checkbalance() public view returns (uint)`
- Returns the total amount of donations received by the contract.

#### `withdraw(uint amount) onlyowner() payable`
- Allows the owner to withdraw a specified `amount` from the contract.
- Uses `revert` to ensure that the owner does not withdraw more than the available balance.
- Uses `assert` to ensure the owner's balance is not negative after withdrawal.

## Usage

### Donation
1. Call the `donate()` function with a specified amount of ETH.
2. The donated amount will be recorded and added to the total balance.

### Checking Balance
1. Call the `checkbalance()` function to view the total donations received.

### Withdrawal (Owner Only)
1. The owner can call the `withdraw()` function with a specified amount to withdraw funds.
2. If the withdrawal amount exceeds the available balance, the transaction will be reverted.

## Security Considerations
- **Owner-Only Withdrawals**: Only the contract owner can withdraw donations to prevent misuse of funds.
- **Assertions**: The contract uses `assert` and `require` to ensure consistency and correctness of donations and withdrawals.
- **Revert on Insufficient Funds**: If a withdrawal exceeds the owner's balance, the transaction is reverted.

## How To Use
-  You can use remix- an online solidity compiler to run this Program 
-  Create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension.
- Copy and paste the following code into the file.
```
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
Compile this contract on the lesft side of remix ,Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar.Then click on the "Deploy" button.
```
## Authors
Aashish Bhambri

## License
This project is licensed under the MIT License.
