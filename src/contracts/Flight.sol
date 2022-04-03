// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "../libraries/SharedStructs.sol";
import "./Ticket.sol";

/**
 * @title Flight
 * @dev Flight contract
 */
contract Flight {

    SharedStructs.FlightDetails flightDetails;
    uint16 availableCapacity;
    uint16 nextTicketNumber;
    uint256 amountPerSeat;
    Ticket[] tickets;

    constructor(string memory _flightNumber, uint256 departureDateTime, uint16 _seatingCapacity, uint256 _amountPerSeat) {
        flightDetails.flightNumber = _flightNumber;
        flightDetails.departureDateTime = departureDateTime;
        availableCapacity = _seatingCapacity;
        nextTicketNumber = 0;
        amountPerSeat = _amountPerSeat;
    }

    function bookTicket(string memory _flightNumber, uint _departureDateTime, uint16 _numberOfSeats) external returns (uint16, address) {
        require(_numberOfSeats <= availableCapacity, "No seats available");
        uint256 _billedAmount = _numberOfSeats * amountPerSeat;
        // TODO: Check balance of buyer's wallet. If insufficient then raise error otherwise deduct from buyer's wallet.
        Ticket ticket = new Ticket(flightDetails.flightNumber, flightDetails.departureDateTime, ++nextTicketNumber, _numberOfSeats, _billedAmount);
        tickets.push(ticket);
        return (nextTicketNumber, address(ticket));
    }

    function delayed(uint256 _revisedDateTime) external pure returns (bool) {
        // TODO: Implement flight delay process, and return true on success.
        return true;
    }
    
    function cancelled() external view returns (uint16) {
        // TODO: Implement flight cancellation process, and return number of tickets processed.
        return availableCapacity;
    }

    function departed(uint256 _departureDateTime) external view returns (uint16) {
        // TODO: Implement settlement process for tickets, and return the number of tickets processed.
        return availableCapacity;
    }
}