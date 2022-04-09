// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title Ticket
 * @dev Ticket contract
 */
contract Ticket {

    SharedStructs.TicketData private ticketData;

    constructor(string memory _flightNumber, uint256 _departureDateTime, uint16 _ticketNumber, SharedStructs.Buyer memory _buyer, uint16 _numberOfSeats, uint256 _amount, address _ticketAgreementAddress) {
        ticketData.flightDetails.flightNumber = _flightNumber;
        ticketData.flightDetails.departureDateTime = _departureDateTime;
        ticketData.ticketNumber = _ticketNumber;
        ticketData.buyer.name = _buyer.name;
        ticketData.buyer.buyerAddress = _buyer.buyerAddress;
        ticketData.numberOfSeats = _numberOfSeats;
        ticketData.amount = _amount;
        ticketData.ticketAgreementAddress = _ticketAgreementAddress;
    }

    function cancel() external pure returns (address) {
        return address(0);
    }

}