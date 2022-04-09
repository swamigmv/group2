// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import {Ticket} from "./Ticket.sol";
import "../Interfaces/FlightInterface.sol";

/**
 * @title Flight
 * @dev Flight contract
 */

contract Flight is FlightInterface {

    SharedStructs.FlightDetails private flightDetails;
    uint16 private availableCapacity;
    uint16 private nextTicketNumber;
    uint256 private amountPerSeat;
    Ticket[] private tickets;

    constructor(string memory flightNumber, uint256 departureDateTime, uint16 seatingCapacity, uint256 perSeatCharge) {
        flightDetails.flightNumber = flightNumber;
        flightDetails.originalDepartureDateTime = departureDateTime;
        flightDetails.actualDepartureDateTime = departureDateTime;
        flightDetails.status = SharedStructs.FlightStatuses.OnTime;
        availableCapacity = seatingCapacity;
        nextTicketNumber = 0;
        amountPerSeat = perSeatCharge;
    }

    function bookTicket(SharedStructs.Buyer calldata buyer, uint16 numberOfSeatsRequired, address ticketAgreementAddress) external override returns (uint16, address) {
        
        require(flightDetails.status == SharedStructs.FlightStatuses.OnTime || flightDetails.status == SharedStructs.FlightStatuses.Delayed, 
        "Booking for this flight is not allowed as it is either departed or cancelled.");

        require(numberOfSeatsRequired <= availableCapacity, "No seats available");

        uint256 billedAmount = numberOfSeatsRequired * amountPerSeat;
        // TODO: Check balance of buyer's wallet. If insufficient then raise error otherwise deduct from buyer's wallet.
        Ticket ticket = new Ticket(address(this), ++nextTicketNumber, buyer, numberOfSeatsRequired, billedAmount, ticketAgreementAddress);
        tickets.push(ticket);
        return (nextTicketNumber, address(ticket));
    }

    function cancel() external override returns (address, uint16) {

        require(flightDetails.status != SharedStructs.FlightStatuses.InTransit && flightDetails.status != SharedStructs.FlightStatuses.Completed, 
        "Flight is either in transit or completed. Hence cannot be cancelled.");

        // Update flight status first so that it will be reflected in the processing.
        flightDetails.status = SharedStructs.FlightStatuses.Cancelled;

        for(uint index = 0; index < tickets.length; index++) {
            tickets[index].settleAccounts();
        }

        return (address(this), uint16(tickets.length));
    }

    function updateDeparture(uint256 newDepartureDateTime) external override returns (address) {

        require(flightDetails.status == SharedStructs.FlightStatuses.OnTime || flightDetails.status == SharedStructs.FlightStatuses.Delayed, 
        "Departure update for this flight is not allowed as it is either departed or cancelled.");

        flightDetails.actualDepartureDateTime = newDepartureDateTime;

        // Check the new departure time. Depending on that update the flight status.
        if (newDepartureDateTime >= block.timestamp)
        {
            flightDetails.status = SharedStructs.FlightStatuses.InTransit;
        } else if (flightDetails.originalDepartureDateTime < newDepartureDateTime) {
            flightDetails.status = SharedStructs.FlightStatuses.Delayed;
        } else {
            flightDetails.status = SharedStructs.FlightStatuses.OnTime;
        }
        return address(this);
    }

    function complete() external override returns (address, uint16) {

        require(flightDetails.status == SharedStructs.FlightStatuses.InTransit, "Flight must be in transit before completing it.");

        // Update flight status first so that it will be reflected in the processing.
        flightDetails.status = SharedStructs.FlightStatuses.Completed;

        Ticket ticket;

        for(uint index = 0; index < tickets.length; index++) {
            ticket = tickets[index];
            if (ticket.getStatus() == SharedStructs.TicketStatuses.Open)
            {
                // Settle only open ticket.
                tickets[index].settleAccounts();
            }
        }

        return (address(this), uint16(tickets.length));
    }

    function getStatus() external override view returns (SharedStructs.FlightStatuses, uint256) {
        return (flightDetails.status, flightDetails.actualDepartureDateTime);
    }
}