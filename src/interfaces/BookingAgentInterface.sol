// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title BookingAgentInterface
 * @dev Interface for the airline agent
 */
interface BookingAgentInterface {
    function flightDelayed(string calldata _flightNumber, uint256 _originalDepartureDateTime, uint256 _newDepartureDateTime) external returns (bool);
    function flightCancelled(string calldata _flightNumber, uint256 _departureDateTime) external returns (bool);
    function flightDeparted(string calldata _flightNumber, uint256 _departureDateTime) external returns (bool);
    function setTicketAgreement(address ticketAgreementAddress) external returns (bool);
}