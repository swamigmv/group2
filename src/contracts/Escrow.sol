// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../interfaces/EscrowInterface.sol";

/**
 * @title Contract for Escrow
 */
contract Escrow is EscrowInterface {

    address selfAddress;    

    /**
     * @notice Creates an instance of Escrow contract
     */
    constructor() payable {
    }

    /**
     * @notice Gets the address of Escrow contract
     */
    function getWallet() external override view returns (address payable) {
        return payable(address(this));
    }

    /**
     * @notice Deposits the amount into the Escrow account
     */
    function deposit() external override payable {
    }

    /**
     * @notice Withdraws the amount from the Escrow account
     */
    function withdraw(address payable payTo, uint256 amount) payable external override {
        payTo.transfer(amount);
    }

}