// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "../libraries/SharedStructs.sol";
import "../interfaces/CustomerStoreInterface.sol";
import "./Ticket.sol";
import "./Flight.sol";

/**
 * @title TicketStore
 * @dev Ticket store contract
 */
contract TicketStore {   

    mapping(uint256 => mapping(string => Flight)) flights;

     function buyTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 numberOfSeats) external pure returns (uint16, address) {
         // TODO: Get flight contract from flight collection. Call book ticket method on the flight.
         return (0, address(0));
     }

     function cancelTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external pure returns (bool) {
        // TODO: Get flight contract from flight collection and then get the ticket. Cancel the ticket.
        return true;         
     }

     function claimRefund(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) external pure returns (bool) {
        // TODO: Get flight contract from flight collection and then get the ticket. Process refund.
        return true;
     }
}