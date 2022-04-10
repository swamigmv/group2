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

   mapping(uint256 => mapping(string => address)) private flights;
   address payable private ticketAgreementAddress;
   address private ownerAddress;

    constructor() payable {
        ownerAddress = msg.sender;
    }

   function addFlight(string calldata flightNumber, uint256 originalDepartureDateTime, uint16 seatingCapacity, uint256 chargePerSeat) external override returns (address) {

      address flightAddress = flights[originalDepartureDateTime][flightNumber];

      if (flightAddress == address(0)) {
         Flight flight = new Flight(flightNumber, originalDepartureDateTime, seatingCapacity, chargePerSeat);
         flightAddress = address(flight);
         flights[originalDepartureDateTime][flightNumber] = flightAddress;
      }

      return flightAddress;
   }

   function updateFlightDeparture(string calldata flightNumber, uint256 originalDepartureDateTime, uint256 newDepartureDateTime) external override returns (address, string memory) {
      address flightAddress = flights[originalDepartureDateTime][flightNumber];
      string memory message;

      if (flightAddress != address(0)) {
         FlightInterface flight = FlightInterface(flightAddress);
         flight.updateDeparture(newDepartureDateTime);
      } else {
         message = "Flight not found.";
      }

      return (flightAddress, message);
   }

   function cancelFlight(string calldata flightNumber, uint256 originalDepartureDateTime) external override returns (address, string memory) {
      address flightAddress = flights[originalDepartureDateTime][flightNumber];
      string memory message;

      if (flightAddress != address(0)) {
         FlightInterface flight = FlightInterface(flightAddress);
         flight.cancel();
      } else {
         message = "Flight not found.";
      }

      return (flightAddress, message);
   }

   function completeFlight(string calldata flightNumber, uint256 originalDepartureDateTime) external override returns (address, string memory) {
      address flightAddress = flights[originalDepartureDateTime][flightNumber];
      string memory message;

      if (flightAddress != address(0)) {
         FlightInterface flight = FlightInterface(flightAddress);
         flight.complete();
      } else {
         message = "Flight not found.";
      }

      return (flightAddress, message);
   }

   function setTicketAgreement(address payable ticketAgreementContractAddress) external override returns (bool){
      ticketAgreementAddress = ticketAgreementContractAddress;
      return true;
   }

   function getFlightAddress(string calldata flightNumber, uint256 originalDepartureDateTime) external override view returns (address, address payable) {
       return (flights[originalDepartureDateTime][flightNumber], ticketAgreementAddress);
   }
}