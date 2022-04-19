// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

/**
 * @title Library containing structures and enumerations shared accross the contracts.
 */
library SharedStructs {

    /**
    * @title Enumeration of the flight statuses
    */
    enum FlightStatuses {
        OnTime,
        Delayed,
        InTransit,
        Completed,
        Cancelled
    }

    /**
    * @title Data structure containing a flight details
    */
    struct FlightDetails {
        string flightNumber;
        uint256 originalDepartureDateTime;
        uint256 actualDepartureDateTime; 
        FlightStatuses status;
        address payable airlineAddress;
    }

    /**
    * @title Data structure containing a buyer details
    */
    struct Buyer {
        string name;
        address payable buyerAddress;
    }

    /**
    * @title Enumeration of the ticket statuses
    */
    enum TicketStatuses {
        Open,
        Cancelled,
        Settled
    }

    /**
    * @title Data structure for the ticket's data
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
        string agreementResult;
        uint256 paidToCustomer;
        uint256 paidToAirline;
    }
    
}