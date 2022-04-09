// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

/**
 * @title AirlineInterface
 * @dev Interface for the airline
 */
interface AirlineInterface {
    function addFlight(string calldata flightNumber, uint256 originalDepartureDateTime, uint16 seatingCapacity, uint256 chargePerSeat) external returns (address);
    function updateFlightDeparture(string calldata flightNumber, uint256 originalDepartureDateTime, uint256 newDepartureDateTime) external returns (address);
    function cancelFlight(string calldata flightNumber, uint256 departureDateTime) external returns (address);
    function completeFlight(string calldata flightNumber, uint256 departureDateTime) external returns (address);
    function setTicketAgreement(address ticketAgreementAddress) external returns (bool);
    function bookTicket(string calldata flightNumber, uint256 originalDepartureDateTime) external returns (address);
}