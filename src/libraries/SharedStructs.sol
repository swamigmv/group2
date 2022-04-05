// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

library SharedStructs {
    /**
    * @title FlightDetails
    * @dev Structure for the flight details
    */
    struct FlightDetails {
        string flightNumber;
        uint256 departureDateTime; 
    }

    /**
    * @title Buyer
    * @dev Structure for the buyer details
    */
    struct Buyer {
        string name;
        address buyerAddress;
    }

    enum TicketStatus {
        Open,
        Cancelled,
        Complete
    }

    /**
    * @title TicketData
    * @dev Structure for the ticket's data
    */
    struct TicketData {
        address ticketAgreementAddress;
        FlightDetails flightDetails;
        uint16 ticketNumber;
        uint256 amount;
        uint16 numberOfSeats;
        uint256 cancelledDateTime;
        TicketStatus status;
    }
}