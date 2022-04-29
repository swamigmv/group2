// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../interfaces/CustomerInterface.sol";
import "../contracts/Ticket.sol";
import {Flight} from "../contracts/Flight.sol";
import "../interfaces/AirlineInterface.sol";

/**
 * @title Contract used by a customer
 */
contract Customer is CustomerInterface {

    address private ownerAddress;
    AirlineInterface private airline; 
    
    /**
    * @notice Create and instance of customer contract
    */
    constructor () payable {
        ownerAddress = msg.sender;
    }

    /**
    * @notice Allows a customer to buy a ticket for the flight
    * @param flightNumber - Flight number for which ticket to be bought
    * @param departureDateTime - Departure date time for the flight
    * @param buyerName - Name of the buyer
    * @param numberOfSeats - Total number of seats to be booked
    * @return Address of the ticket booked
    * @return Number of the booked ticket
    * @return Message giving the summary the execution
    */
    function buyTicket(string calldata flightNumber, uint256 departureDateTime, string calldata buyerName, uint16 numberOfSeats) 
    external override payable returns (address, uint16, string memory) {
        uint16 ticketNumber;
        address ticketAddress;
        string memory message;

        (address payable flightAddress, address ticketAgreementAddress) = airline.getTicketBookingConfiguration(flightNumber, departureDateTime);

        // Confirm that flight is found.
        if (flightAddress == address(0)) {
            message = "Specified flight is not available for the booking.";
        } else {
            FlightInterface flight = FlightInterface(flightAddress);

            SharedStructs.Buyer memory buyer;
            buyer.name = buyerName;
            buyer.buyerAddress = payable(tx.origin);
            (ticketNumber, ticketAddress, message) = flight.bookTicket{value: msg.value}(buyer, numberOfSeats, ticketAgreementAddress);
        }

        emit BuyTicketResult(ticketAddress, ticketNumber, message);

        return (ticketAddress, ticketNumber, message);

    }

    /**
    * @notice Gets the ticket for the flight
    * @param flightNumber - Flight number for which ticket address to be fetch
    * @param departureDateTime - Departure time of the flight for which ticket address to be fetch
    * @param ticketNumber - Ticket number for which address to be fetch
    * @return Ticket address
    */
    function getTicketAddress(string calldata flightNumber, uint256 departureDateTime, uint16 ticketNumber) external override view returns (address, string memory) {
        string memory message;
        address ticketAddress = address(0);
        (address payable flightAddress,) = airline.getTicketBookingConfiguration(flightNumber, departureDateTime);

        // Confirm that flight is found.
        if (flightAddress == address(0)) {
            message = "Specified flight is not available.";
        } else {
            FlightInterface flight = FlightInterface(flightAddress);
            (ticketAddress, message) = flight.getTicketAddress(ticketNumber);
        }

        return (ticketAddress, message);
    }

    /**
    * @notice Allows a customer to cancel the ticket
    * @param ticketAddress - Address of the ticket to be cancelled
    * @return Message giving the summary the execution
    */
    function cancelTicket(address ticketAddress) external override returns (string memory){
        TicketInterface ticket = TicketInterface(ticketAddress);
        string memory message = ticket.cancel();

        emit CancelTicketResult(message);

        return message;
    }

    /**
    * @notice Allows a customer to settle the ticket
    * @param ticketAddress - Address of the ticket to be cancelled
    * @return Message giving the summary the execution
    */
    function settleTicket(address ticketAddress) external override returns (string memory) {
        TicketInterface ticket = TicketInterface(ticketAddress);
        string memory message = ticket.settleAccounts();

        emit SettleTicketResult(message);

        return message;
    }

    /**
    * @notice Allows the owner of the contract to set address of the airline contract to be used
    * @param airlineAddress - Address of the airline contract
    * @return True on success
    */
    function setAirline(address airlineAddress) external override ownerOnly returns (bool) {
        airline = AirlineInterface(airlineAddress);
        return true;
    }

    /**
    * @notice Modifier to ensure that the method is executed by the owner of the contract
    */
    modifier ownerOnly {
        require(tx.origin == ownerAddress, "You are not allowed to perform this operation");
        _;
    }
}