// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "../libraries/SharedStructs.sol";

/**
 * @title CustomerInterface
 * @dev Interface for the customer
 */
interface CustomerInterface {
    function buyTicket(string calldata _flightNumber, uint256 _departureDateTime, uint16 numberOfSeats) external returns (uint16, address);
    function cancelTicket(string calldata _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external returns (bool);
    function claimRefund(string calldata _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external returns (bool);
}