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
        Departed,
        Cancelled
    }

    /**
    * @title Data structure containing a flight details
    */
    struct FlightDetails {
        string flightNumber;
        address airlineAddress;
        uint256 originalDepartureDateTime;
        uint256 actualDepartureDateTime; 
        FlightStatuses status;
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
        address ticketAgreementAddress;
        address flightAddress;
        address payable escrowContractAddress;
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
    
            
    struct TicketInfo {
        address ticketAddress;
        uint16 ticketNumber;
        string travellerName;
        address buyerAddress;
        uint16 numberOfSeatsBooked;
        uint256 ticketAmount;
        SharedStructs.TicketStatuses ticketStatus; 
        uint256 cancellationDateTime;
        string settleAccountResult;
        uint256 amountPaidToCustomer;
        uint256 amountPaidToAireline;
    }

}