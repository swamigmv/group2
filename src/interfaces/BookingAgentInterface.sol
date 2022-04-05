// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "../libraries/SharedStructs.sol";

/**
 * @title BookingAgentInterface
 * @dev Interface for the airline agent
 */
interface BookingAgentInterface {
    function flightDelayed(string memory _flightNumber, uint256 _originalDepartureDateTime, uint256 _newDepartureDateTime) external returns (bool);
    function flightCancelled(string memory _flightNumber, uint256 _departureDateTime) external returns (bool);
    function flightDeparted(string memory _flightNumber, uint256 _departureDateTime) external returns (bool);
}