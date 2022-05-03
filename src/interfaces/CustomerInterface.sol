// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title Interface for customer contract.
 */
interface CustomerInterface {
    
    /**
    * @notice Event is raised to return buyTicket result to Web3 client
    * @return ticketAddress - Address of the ticket booked
    * @return ticketNumber - Number of the booked ticket
    * @return log - Log of the execution
    */
    event BuyTicketResult(address ticketAddress, uint16 ticketNumber, string log);

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
        external payable returns (address, uint16, string memory);

    /**
    * @notice Gets the ticket for the flight
    * @param flightNumber - Flight number for which ticket address to be fetch
    * @param departureDateTime - Departure time of the flight for which ticket address to be fetch
    * @param ticketNumber - Ticket number for which address to be fetch
    * @return Ticket address
    * @return Message giving the summary the execution
    */
    function getTicketAddress(string calldata flightNumber, uint256 departureDateTime, uint16 ticketNumber) external view returns (address, string memory);

    /**
    * @notice Event is raised to return cancelTicket result to Web3 client
    * @return log - Log of the execution
    */
    event CancelTicketResult(string log);

    /**
    * @notice Allows a customer to cancel the ticket
    * @param ticketAddress - Address of the ticket to be cancelled
    * @return Message giving the summary the execution
    */
    function cancelTicket(address ticketAddress) external returns (string memory);

    /**
    * @notice Event is raised to return settleTicket result to Web3 client
    * @return log - Log of the execution
    */
    event SettleTicketResult(string log);

    /**
    * @notice Allows a customer to settle the ticket
    * @param ticketAddress - Address of the ticket to be cancelled
    * @return Message giving the summary the execution
    */
    function settleTicket(address ticketAddress) external returns (string memory);

    /**
    * @notice Allows the owner of the contract to set address of the airline contract to be used
    * @param airlineAddress - Address of the airline contract
    * @return True on success
    */
    function setAirline(address airlineAddress) external returns (bool);


    function getBalance(address custAddress) external returns (address ticketAddress, uint256 balance);

    event GetBalanceResult(address ticketAddress, uint256 balance);
}