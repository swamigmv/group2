// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import {Ticket} from "./Ticket.sol";
import "../interfaces/FlightInterface.sol";
import "../libraries/SharedConstants.sol";

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

    constructor(string memory flightNumber, uint256 departureDateTime, uint16 seatingCapacity, uint256 perSeatCharge) payable {
        flightDetails.flightNumber = flightNumber;
        flightDetails.originalDepartureDateTime = departureDateTime;
        flightDetails.actualDepartureDateTime = departureDateTime;
        flightDetails.status = SharedStructs.FlightStatuses.OnTime;
        availableCapacity = seatingCapacity;
        nextTicketNumber = 0;
        amountPerSeat = perSeatCharge;
    }

    function bookTicket(SharedStructs.Buyer calldata buyer, uint16 numberOfSeatsRequired, address payable ticketAgreementAddress) external override payable 
    returns (uint16, address, string memory) {
        
        string memory message;
        uint16 ticketNumber;
        address payable ticketAddress = payable(address(0));

        if (flightDetails.status != SharedStructs.FlightStatuses.OnTime && flightDetails.status != SharedStructs.FlightStatuses.Delayed) {
            message = "Booking for this flight is not allowed as it is either departed or cancelled.";
        } else if (numberOfSeatsRequired > availableCapacity) {
            message = "No seats available.";
        } else {

            uint256 billedAmount = numberOfSeatsRequired * amountPerSeat;
            
            // Check balance of buyer's wallet. If insufficient then raise error otherwise deduct from buyer's wallet.
            require(buyer.buyerAddress.balance >= billedAmount, "Insufficient balance in buyer's account");

            Ticket ticket = new Ticket(address(this), ++nextTicketNumber, buyer, numberOfSeatsRequired, billedAmount, ticketAgreementAddress);
            // TODO: The below line is not working. Fix the issue.
            payable(address(ticket)).transfer(billedAmount);
            //payable(address(SharedConstants.PAYMENT_SERVICE_ACCOUNT)).transfer(billedAmount);
            tickets.push(ticket);
            ticketNumber = nextTicketNumber;
            ticketAddress = payable(address(ticket));
            message = "Ticket booked successfully.";
            availableCapacity -= numberOfSeatsRequired;

        }

        return (ticketNumber, ticketAddress, message);
    }

    function cancel() external override returns (address, uint16, string memory) {

        uint16 numberOfTickets;
        string memory message;

        if (flightDetails.status == SharedStructs.FlightStatuses.InTransit || flightDetails.status == SharedStructs.FlightStatuses.Completed) { 
            message = "Flight is either in transit or completed. Hence cannot be cancelled.";
            numberOfTickets = 0;
        } else {
            // Update flight status first so that it will be reflected in the processing.
            flightDetails.status = SharedStructs.FlightStatuses.Cancelled;

            for(uint index = 0; index < tickets.length; index++) {
                tickets[index].settleAccounts();
            }
            numberOfTickets = uint16(tickets.length);
            message = "Flight is cancelled and tickets are settled successfully.";
        }

        return (address(this), numberOfTickets, message);
    }

    function updateDeparture(uint256 newDepartureDateTime) external override returns (address, string memory) {

        string memory message;

        if (flightDetails.status != SharedStructs.FlightStatuses.OnTime && flightDetails.status != SharedStructs.FlightStatuses.Delayed) {
            message = "Departure update for this flight is not allowed as it is either departed or cancelled.";
        } else {
            flightDetails.actualDepartureDateTime = newDepartureDateTime;

            // Check the new departure time. Depending on that update the flight status.
            if (newDepartureDateTime >= block.timestamp)
            {
                flightDetails.status = SharedStructs.FlightStatuses.InTransit;
            } else if (flightDetails.originalDepartureDateTime < newDepartureDateTime) {
                flightDetails.status = SharedStructs.FlightStatuses.Delayed;
            } else {
                flightDetails.status = SharedStructs.FlightStatuses.OnTime;
                message = "Flight is updated successfully.";
            }
        }
        return (address(this), message);
    }

    function complete() external override returns (address, uint16, string memory) {

        uint16 numberOfTickets;
        string memory message;

        if (flightDetails.status != SharedStructs.FlightStatuses.InTransit) {
            message =  "Flight must be in transit before completing it.";
            numberOfTickets = 0;
        } else {
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
            message =  "Flight status is updated and tickets are settled.";
            numberOfTickets = uint16(tickets.length);
        }

        return (address(this), numberOfTickets, message);
    }

    function getStatus() external override view returns (SharedStructs.FlightStatuses, uint256) {
        return (flightDetails.status, flightDetails.actualDepartureDateTime);
    }
}