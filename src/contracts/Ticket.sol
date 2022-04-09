// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../interfaces/FlightInterface.sol";
import "../interfaces/TicketInterface.sol";

/**
 * @title Ticket
 * @dev Ticket contract
 */
contract Ticket is TicketInterface {

    SharedStructs.TicketData private ticketData;

    constructor(address flightAddress, uint16 ticketNumber, SharedStructs.Buyer memory buyer, uint16 numberOfSeats, uint256 amount, 
    address ticketAgreementAddress) {
        ticketData.flightAddress = flightAddress;
        ticketData.ticketNumber = ticketNumber;
        ticketData.buyer.name = buyer.name;
        ticketData.buyer.buyerAddress = buyer.buyerAddress;
        ticketData.numberOfSeats = numberOfSeats;
        ticketData.amount = amount;
        ticketData.ticketAgreementAddress = ticketAgreementAddress;
    }

    function cancel() external override payable returns (address, string memory) {
        // TODO: Cancel the ticket.
        return (address(0), "");
    }
    
    function settleAccounts() external override payable returns (address, string memory) {
        // TODO: Cancel the ticket.
        return (address(0), "");
    }

    function getStatus() external override view returns (SharedStructs.TicketStatuses) {
        return ticketData.status;
    }
}