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
    address payable ticketAgreementAddress) payable {
        ticketData.flightAddress = flightAddress;
        ticketData.ticketNumber = ticketNumber;
        ticketData.buyer.name = buyer.name;
        ticketData.buyer.buyerAddress = buyer.buyerAddress;
        ticketData.numberOfSeats = numberOfSeats;
        ticketData.amount = amount;
        ticketData.ticketAgreementAddress = ticketAgreementAddress;
    }

    function cancel() external override payable returns (address, string memory) {
        string memory message;
        if (ticketData.status == SharedStructs.TicketStatuses.Open) {
            // Update the status and timestamp of the ticket, so that it will be available during account settlements.
            ticketData.cancelledDateTime = block.timestamp;
            ticketData.status = SharedStructs.TicketStatuses.Cancelled;
            this.settleAccounts();
        }
        else {
            message = "Ticket is either settled or cancelled. Hence, cannot be cancelled";
        }
        return (address(this), message);
    }
    
    function settleAccounts() external override payable returns (address, string memory) {
        string memory message;
        address returnValue;

        if (ticketData.ticketAgreementAddress != address(0)) {
            (bool success,) = ticketData.ticketAgreementAddress.delegatecall(abi.encodeWithSignature("settleAccounts()"));
            if (success) {
                ticketData.status = SharedStructs.TicketStatuses.Settled;
                returnValue = address(this);
                message = "Accounts settled successfully.";
            } else {
                returnValue = address(this);
                message = "Error occured while settling the accounts.";
            }
        }

        return (returnValue, message);
    }

    function getStatus() external override view returns (SharedStructs.TicketStatuses) {
        return ticketData.status;
    }
}