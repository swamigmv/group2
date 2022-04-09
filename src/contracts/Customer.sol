// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../interfaces/CustomerInterface.sol";
import "./Ticket.sol";
import {Flight} from "./Flight.sol";

/**
 * @title Customer
 * @dev Customer contract
 */
contract Customer is CustomerInterface {

    function buyTicket(string calldata flightNumber, uint256 departureDateTime, uint16 numberOfSeats) external override pure returns (address, string memory) {
        // TODO: Initialize buyer structure and then call book ticket method on Airline contract.
        return (address(0), "");
    }

    function cancelTicket(address ticketAddress) external override payable returns (address, string memory){
        TicketInterface ticket = TicketInterface(ticketAddress);
        return ticket.cancel();
    }

    function settleTicket(address ticketAddress) external override payable returns (address, string memory) {
        TicketInterface ticket = TicketInterface(ticketAddress);
        return ticket.settleAccounts();
    }
}