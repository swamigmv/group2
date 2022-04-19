// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../interfaces/AirlineInterface.sol";
import "./Ticket.sol";
import {Flight} from "./Flight.sol";

/**
 * @title Contract used by an Airline
 * @notice Contains members that are used by Airline personales
 */
contract Airline is AirlineInterface {

   mapping(uint256 => mapping(string => address)) private flights;
   address payable private ticketAgreementAddress;
   address private ownerAddress;

   /**
    * @notice Creates an instance of Airline contract
    */
   constructor() payable {
      ownerAddress = msg.sender;
   }

   /**
    * @notice Adds a flight details in the contract, so that it will be available for the transctions
    * @param flightNumber - Flight number
    * @param originalDepartureDateTime - Scheduled default departure date time
    * @param seatingCapacity - Seating capacity of the flight
    * @param chargePerSeat - Charge per seat
    * @return Address of the instance of the flight contract added
    * @return Message giving the summary the execution
    */
   function addFlight(string calldata flightNumber, uint256 originalDepartureDateTime, uint16 seatingCapacity, uint256 chargePerSeat) 
   external override returns (address, string memory) {

      string memory message;
      address flightAddress = flights[originalDepartureDateTime][flightNumber];

      if (flightAddress == address(0)) {
         Flight flight = new Flight(flightNumber, originalDepartureDateTime, seatingCapacity, chargePerSeat, payable(address(this)));
         flightAddress = address(flight);
         flights[originalDepartureDateTime][flightNumber] = flightAddress;
         message = "Flight added successfully";
      }
      else {
         message = "Flight is already added";
      }

      return (flightAddress, message);
   }

   /**
    * @notice Updates flight departure date time
    * @param flightNumber - Flight number
    * @param originalDepartureDateTime - Original departure date time of the flight
    * @param newDepartureDateTime - New departure date time of the flight
    * @return Address of the flight contract updated
    * @return Status of the flight depending on the new departure date time
    * @return Message giving the summary the execution
    */
   function updateFlightDeparture(string calldata flightNumber, uint256 originalDepartureDateTime, uint256 newDepartureDateTime) external override 
   returns (address, SharedStructs.FlightStatuses, string memory) {

      address flightAddress = flights[originalDepartureDateTime][flightNumber];
      string memory message;
      SharedStructs.FlightStatuses flightStatus;

      if (flightAddress != address(0)) {
         FlightInterface flight = FlightInterface(flightAddress);
         (flightStatus, message) = flight.updateDeparture(newDepartureDateTime);
      } else {
         message = "Flight not found";
      }

      return (flightAddress, flightStatus, message);
   }

   /**
    * @notice Cancels the flight
    * @param flightNumber - Flight number
    * @param originalDepartureDateTime - Original departure date time of the flight
    * @return Address of the flight contract updated
    * @return Total number of tickets cancelled
    * @return Message giving the summary the execution
    */
   function cancelFlight(string calldata flightNumber, uint256 originalDepartureDateTime) external override returns (address, uint16, string memory) {

      address flightAddress = flights[originalDepartureDateTime][flightNumber];
      string memory message;
      uint16 numberOfTickets;

      if (flightAddress != address(0)) {
         FlightInterface flight = FlightInterface(flightAddress);
         (numberOfTickets, message) = flight.cancel();
      } else {
         numberOfTickets = 0;
         message = "Flight not found";
      }

      return (flightAddress, numberOfTickets, message);
   }

   /**
    * @notice Marks the flight as completed
    * @param flightNumber - Flight number
    * @param originalDepartureDateTime - Original departure date time of the flight
    * @return Address of the flight contract updated
    * @return Number of tickets settled
    * @return Message giving the summary the execution
    */
   function completeFlight(string calldata flightNumber, uint256 originalDepartureDateTime) external override returns (address, uint16, string memory) {

      address flightAddress = flights[originalDepartureDateTime][flightNumber];
      uint16 numberOfTickets;
      string memory message;

      if (flightAddress != address(0)) {
         FlightInterface flight = FlightInterface(flightAddress);
         (numberOfTickets, message) = flight.complete();
      } else {
         numberOfTickets = 0;
         message = "Flight not found";
      }

      return (flightAddress, numberOfTickets, message);
   }

   /**
    * @notice Sets the ticket agreement contract to be used for new tickets
    * @param ticketAgreementContractAddress - Address of the ticket agreement contract
    */
   function setTicketAgreement(address payable ticketAgreementContractAddress) external override returns (bool){
      ticketAgreementAddress = ticketAgreementContractAddress;
      return true;
   }

   /**
    * @notice Gets the ticket booking configuration
    * @param flightNumber - Flight number for which the booking to be made
    * @param originalDepartureDateTime - Original departure time of the flight for which the booking to be made
    * @return Contract address of the flight for which the booking to be made
    * @return Address of ticket agreement contract to be used for new ticket
    */
   function getTicketBookingConfiguration(string calldata flightNumber, uint256 originalDepartureDateTime) external override view returns (address, address payable) {
       return (flights[originalDepartureDateTime][flightNumber], ticketAgreementAddress);
   }
}