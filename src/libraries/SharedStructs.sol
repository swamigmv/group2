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
        Completed,
        Cancelled
    }

    /**
    * @title FlightDetails
    * @dev Structure for the flight details
    */
    struct FlightDetails {
        string flightNumber;
        uint256 originalDepartureDateTime;
        uint256 actualDepartureDateTime; 
        FlightStatuses status;
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
        Settled
    }

    /**
    * @title TicketData
    * @dev Structure for the ticket's data
    */
    struct TicketData {
        address payable ticketAgreementAddress;
        address flightAddress;
        uint16 ticketNumber;
        Buyer buyer;
        uint256 amount;
        uint16 numberOfSeats;
        uint256 cancelledDateTime;
        TicketStatuses status;
    }
    
}