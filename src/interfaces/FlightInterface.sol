// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title FlightInterface
 * @dev Interface for the flight
 */
interface FlightInterface {
    function bookTicket(SharedStructs.Buyer calldata buyer, uint16 numberOfSeatsRequired, address payable ticketAgreementAddress) external payable 
    returns (uint16, address, string memory);
    function cancel() external returns (address, uint16, string memory);
    function updateDeparture(uint256 newDepartureDateTime) external returns (address, string memory);
    function complete() external returns (address, uint16, string memory);
    function getStatus() external returns (SharedStructs.FlightStatuses, uint256);
}