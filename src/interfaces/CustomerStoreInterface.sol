// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "../libraries/SharedStructs.sol";

/**
 * @title CustomerStoreInterface
 * @dev Interface for the customer store
 */
interface CustomerStoreInterface {
    function buyTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 numberOfSeats) external returns (address);
    function cancelTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external returns (bool);
    function claimRefund(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external returns (bool);
}