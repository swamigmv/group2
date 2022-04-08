// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title CustomerInterface
 * @dev Interface for the customer
 */
interface CustomerInterface {
    function buyTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 numberOfSeats) external returns (uint16, address);
    function cancelTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external returns (bool);
    function claimRefund(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external returns (bool);
}