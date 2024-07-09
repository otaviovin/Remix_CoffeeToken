// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Openzepelin is a great option to create your won ERC20 token, Our contracts
// are often used via inheritance, and here we’re reusing ERC20 for both the basic standard
// implementation and the name, symbol, and decimals optional extensions
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeToken is ERC20, AccessControl { // AccessControle: allows you to manage permissions 
// and control access to certain functions or operations within your contract
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE"); // declares a constant 
    // MINTER_ROLE that represents a unique identifier (hash) for a specific role

    event CoffeePurchased(address indexed receiver, address indexed buyer); // defines an event
    // CoffeePurchased that signals the purchase of coffee, logging the addresses of both the 
    // receiver and the buyer on the blockchain for external monitoring and processing

    constructor() ERC20("CoffeeToken", "CFE") { // constructor initializes an ERC20 token contract 
    //named "CoffeeToken" with symbol "CFE"
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender); // grants full administrative control over the contract to the msg.sender
        _grantRole(MINTER_ROLE, msg.sender); // grants msg.sender to mint new tokens within the ERC20 token contract
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        // is callable only in the constructor once. That means, once the token is deployed, 
        // there is no more access for the internal mint functionality, the supply of tokens remains 
        // fixed
        _mint(to, amount); 
    }

    function buyOneCoffee() public {
        // this function let burn 1 token from own balance when de customer buys a coffee
        // Burning tokens effectively removes them from circulation, reducing the total supply 
        // of the token.
        _burn(_msgSender(), 1);
        emit CoffeePurchased(_msgSender(), _msgSender());
    }

    function buyOneCoffeeFrom(address account) public {
        // This function demonstrates token transfers and allowances in Ethereum smart contracts
        // to facilitate transactions between msg.sender and customer while maintaining control
        // over token spending and reducing the token supply through burning.
        // **********************************************************************************
        // It first spends 1 unit of the token from account's allowance to _msgSender(). This assumes 
        // that account has previously approved _msgSender() to spend tokens on its behalf using the 
        // approve function.
        // Then, it burns 1 unit of the token from account's balance.
        // Finally, it emits a CoffeePurchased event, , indicating that _msgSender() (the buyer) has 
        // purchased coffee from account (the seller or provider).
        _spendAllowance(account, _msgSender(), 1);
        _burn(account, 1);
        emit CoffeePurchased(_msgSender(), account);
    }
}