// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title FlightRepository
 * @dev Flight repository contract
 */
contract FlightRepository {

    function getFlightStatus(string memory _flightNumber, uint256 _departureDate) external pure returns (SharedStructs.FlightStatuses, uint256) {
        return (SharedStructs.FlightStatuses.OnTime, 0);
    }
}