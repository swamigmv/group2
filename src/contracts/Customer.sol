// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../interfaces/CustomerInterface.sol";
import "./Ticket.sol";
import {Flight} from "./Flight.sol";
import "../interfaces/AirlineInterface.sol";

/**
 * @title Customer
 * @dev Customer contract
 */
contract Customer is CustomerInterface {

    address private ownerAddress;
    AirlineInterface private airline; 
    
    constructor () payable {
        ownerAddress = msg.sender;
    }


    function buyTicket(string calldata flightNumber, uint256 departureDateTime, string calldata buyerName, uint16 numberOfSeats) external override 
    payable returns (uint16, address, string memory) {
        
        (address flightAddress, address payable ticketAgreementAddress) = airline.getFlightAddress(flightNumber, departureDateTime);

        // Confirm that flight is found.
        require(flightAddress != address(0), "Specified flight is not available for the booking.");

        FlightInterface flight = FlightInterface(payable(flightAddress));

        SharedStructs.Buyer memory buyer;
        buyer.name = buyerName;
        buyer.buyerAddress = tx.origin;

        return flight.bookTicket(buyer, numberOfSeats, ticketAgreementAddress);

    }

    function cancelTicket(address ticketAddress) external override payable returns (address, string memory){
        TicketInterface ticket = TicketInterface(ticketAddress);
        return ticket.cancel();
    }

    function settleTicket(address ticketAddress) external override payable returns (address, string memory) {
        TicketInterface ticket = TicketInterface(ticketAddress);
        return ticket.settleAccounts();
    }

    function setAirline(address airlineAddress) external override ownerOnly returns (bool) {
        airline = AirlineInterface(airlineAddress);
        return true;
    }

    modifier ownerOnly {
        require(tx.origin == ownerAddress, "You are not allowed to perform this operation");
        _;
    }
}