// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../interfaces/AirlineInterface.sol";
import "./Ticket.sol";
import {Flight} from "./Flight.sol";

/**
 * @title TicketStore
 * @dev Ticket store contract
 */
contract Airline is AirlineInterface {   

   mapping(uint256 => mapping(string => Flight)) private flights;
   address private ticketAgreementAddress;

   function addFlight(string calldata flightNumber, uint256 originalDepartureDateTime) external override returns (address) {
      // TODO: Add flight in the mapping.
      return address(0);
   }

   function updateFlightDeparture(string calldata flightNumber, uint256 originalDepartureDateTime, uint256 newDepartureDateTime) external override returns (address) {
      // TODO: Get the flight object from the mapping and update the flight departure.
      return address(0);
   }

   function cancelFlight(string calldata flightNumber, uint256 departureDateTime) external override returns (address) {
      // TODO: Get the flight object from the mapping and cancel the flight.
      return address(0);
   }

   function completeFlight(string calldata flightNumber, uint256 departureDateTime) external override returns (address) {
      // TODO: Get the flight object from the mapping and complete the flight.
      return address(0);
   }

   function setTicketAgreement(address ticketAgreementContractAddress) external override returns (bool){
      ticketAgreementAddress = ticketAgreementContractAddress;
      return true;
   }

   function bookTicket(string calldata flightNumber, uint256 originalDepartureDateTime) external override returns (address){
      // TODO: Get the flight object from the mapping and complete the flight.
      return address(0);
   }
}