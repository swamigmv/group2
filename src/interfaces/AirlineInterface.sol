// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title Interface specifying the methods exposed by Airline contract
 */
interface AirlineInterface {
    
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
    external returns (address, string calldata);

    /**
    * @notice Updates flight departure date time
    * @param flightNumber - Flight number
    * @param originalDepartureDateTime - Original departure date time of the flight
    * @param newDepartureDateTime - New departure date time of the flight
    * @return Message giving the summary the execution
    */
    function updateFlightDeparture(string calldata flightNumber, uint256 originalDepartureDateTime, uint256 newDepartureDateTime) 
    external returns (address, SharedStructs.FlightStatuses, string memory);

    /**
    * @notice Cancels the flight
    * @param flightNumber - Flight number
    * @param originalDepartureDateTime - Original departure date time of the flight
    * @return Address of the flight contract updated
    * @return Total number of tickets cancelled
    * @return Message giving the summary the execution
    */
    function cancelFlight(string calldata flightNumber, uint256 originalDepartureDateTime) external returns (address, uint16, string memory);

    /**
    * @notice Marks the flight as completed
    * @param flightNumber - Flight number
    * @param originalDepartureDateTime - Original departure date time of the flight
    * @return Address of the flight contract updated
    * @return Number of tickets settled
    * @return Message giving the summary the execution
    */
    function completeFlight(string calldata flightNumber, uint256 originalDepartureDateTime) external returns (address, uint16, string memory);

    /**
    * @notice Sets the ticket agreement contract to be used for new tickets
    * @param ticketAgreementAddress - Address of the ticket agreement contract
    */
    function setTicketAgreement(address payable ticketAgreementAddress) external returns (bool);

    /**
    * @notice Gets the ticket booking configuration
    * @param flightNumber - Flight number for which the booking to be made
    * @param originalDepartureDateTime - Original departure time of the flight for which the booking to be made
    * @return Contract address of the flight for which the booking to be made
    * @return Address of ticket agreement contract to be used for new ticket
    */
    function getTicketBookingConfiguration(string calldata flightNumber, uint256 originalDepartureDateTime) external view returns (address, address payable);
}