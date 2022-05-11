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
     * @notice Pays amount to customer account
     * @param amount - Amount to be paid to the customer
     */
    function payToCustomer(uint256 amount) external payable;

    /**
     * @notice Pays amount to airline account
     * @param amount - Amount to be paid to the airline
     */
    function payToAirline(uint256 amount) payable external;

}