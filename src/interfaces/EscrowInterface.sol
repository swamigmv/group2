// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title Interface specifying the methods exposed by Escrow contract
 */
interface EscrowInterface {
    
    /**
    * @notice Gets the address of the wallet
    * @return Address of the wallet
    */
    function getWallet() external returns (address payable);

    /**
     * @notice Deposits the amount into the Escrow account
     */
    function deposit() external payable;

    /**
     * @notice Withdraws the amount from the Escrow account
     */
    function withdraw(address payable payTo, uint256 amount) payable external;

}