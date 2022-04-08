// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.6;

import "../libraries/SharedStructs.sol";
import "../interfaces/CustomerInterface.sol";
import "../interfaces/BookingAgentInterface.sol";
import "./Ticket.sol";
import "./Flight.sol";

/**
 * @title TicketStore
 * @dev Ticket store contract
 */
contract TicketStore is CustomerInterface, BookingAgentInterface {   

   mapping(uint256 => mapping(string => Flight)) private flights;
   address private ticketAgreementAddress;

   function buyTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 numberOfSeats) override external pure returns (uint16, address) {
      // TODO: Get flight contract from flight collection. Call book ticket method on the flight.
      return (0, address(0));
   }

   function cancelTicket(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) override external pure returns (bool) {
      // TODO: Get flight contract from flight collection and then get the ticket. Cancel the ticket.
      return true;         
   }

   function claimRefund(string memory _flightNumber, uint256 _departureDateTime, uint16 ticketNumber) override external pure returns (bool) {
      // TODO: Get flight contract from flight collection and then get the ticket. Process refund.
      return true;
   }

   function flightDelayed(string memory _flightNumber, uint256 _originalDepartureDateTime, uint256 _newDepartureDateTime) override external pure returns (bool) {
      return true;
   }

   function flightCancelled(string memory _flightNumber, uint256 _departureDateTime) override external pure returns (bool) {
      return true;
   }
   
   function flightDeparted(string memory _flightNumber, uint256 _departureDateTime) override external pure returns (bool) {
      return true;
   }

   function setTicketAgreement(address _ticketAgreementAddress) override external returns (bool) {
      ticketAgreementAddress = _ticketAgreementAddress;
   }
}