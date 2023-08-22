
// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

// Import necessary contracts from OpenZeppelin library
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

// Import Hardhat's console for debugging (optional)
import "hardhat/console.sol";

// Define the DegenToken contract inheriting from ERC20 and Ownable
contract cryptoCurrency is ERC20, Ownable {
    // Constructor to initialize the token with name "Degen" and symbol "DGN"
    constructor() ERC20("Crypto", "CPT") {}

    // Event emitted when tokens are redeemed
    event cryptoRedeemed(address account, uint chosenOption); 

    // Function to mint tokens and assign them to a specific address, only accessible by the owner
    function mintCrypto(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to transfer tokens from the caller's address to another address
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), to, amount);
        return true;
    }

    // Function to get the token balance of the caller's address
    function getBalance() external view returns (uint) {
        return balanceOf(msg.sender);
    }

    // Function to redeem tokens for a chosen option, burning the required tokens
    function redeemCrypto(uint chosenOption) public {
        uint requiredCrypto = chosenOption * 10; 
        require(balanceOf(msg.sender) >= requiredCrypto, "Not enough Crypto");
        burnTokens(requiredCrypto);
        emit cryptoRedeemed(msg.sender, chosenOption);
    }

    // Function to burn (destroy) a specific amount of tokens from the caller's address
    function burnTokens(uint amount) public {
        _burn(msg.sender, amount);
    }
}
