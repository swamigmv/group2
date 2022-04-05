// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "../libraries/SharedStructs.sol";

/**
 * @title Ticket
 * @dev Ticket contract
 */
contract Ticket {

    SharedStructs.FlightDetails flightDetails;
    uint16 ticketNumber;
    uint256 amount;
    uint16 numberOfSeats;

    constructor(string memory _flightNumber, uint256 _departureDateTime, uint16 _ticketNumber, uint16 _numberOfSeats, uint256 _amount) {
        flightDetails.flightNumber = _flightNumber;
        flightDetails.departureDateTime = _departureDateTime;
        ticketNumber = _ticketNumber;
        numberOfSeats = _numberOfSeats;
        amount = _amount;
    }

    function cancel() external pure returns (address) {
        return address(0);
    }

}