// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../interfaces/EscrowInterface.sol";
import "../interfaces/AirlineInterface.sol";

/**
 * @title Contract for Escrow
 */
contract Escrow is EscrowInterface {

    address payable customerAddress;
    AirlineInterface airline;    

    /**
     * @notice Creates an instance of Escrow contract
     */
    constructor(address payable customer, AirlineInterface airlineContract) payable {
        customerAddress = customer;
        airline = airlineContract;
    }

    /**
     * @notice Gets the address of Escrow contract
     */
    function getWallet() external override view returns (address payable) {
        return payable(address(this));
    }

    /**
     * @notice Pays amount to customer account
     * @param amount - Amount to be paid to the customer
     */
    function payToCustomer(uint256 amount) external override payable {
        customerAddress.transfer(amount);
    }

    /**
     * @notice Pays amount to airline account
     * @param amount - Amount to be paid to the airline
     */
    function payToAirline(uint256 amount) external override payable {
        airline.getWallet().transfer(amount);
    }

}