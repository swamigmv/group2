// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

library SharedStructs {

    /**
    * @title FlightStatuses
    * @dev Enum for the flight status
    */
    enum FlightStatuses {
        OnTime,
        Delayed,
        InTransit,
        Completed
    }

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

    /**
    * @title TicketStatuses
    * @dev Enum for the ticket status
    */
    enum TicketStatuses {
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
        Buyer buyer;
        uint256 amount;
        uint16 numberOfSeats;
        uint256 cancelledDateTime;
        TicketStatuses status;
    }

    struct FlightRecord {
        string flightNumber;
        uint256 departureDate;
        uint256 scheduledDepartureDateTime;
        uint256 actualDepartureDateTime;
        FlightStatuses status;
    }
}