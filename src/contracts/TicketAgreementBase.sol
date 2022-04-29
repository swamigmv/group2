// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../libraries/SharedFuncs.sol";
import "../interfaces/FlightInterface.sol";
import "../interfaces/AirlineInterface.sol";
import "../interfaces/EscrowInterface.sol";

/**
 * @title Base contract for all ticket agreements
 */
abstract contract TicketAgreementBase {
         
    SharedStructs.TicketData internal ticketData;
    string internal status;
        
    uint256 internal ticketCancellationWindow = 2 hours;

    /**
     * @notice Cancels the ticket
     */
    function cancelTicket() external virtual {

        // Get current date time
        uint256 currentDateTime = SharedFuncs.getCurrentDateTime();
        // Get flight object
        FlightInterface flight = FlightInterface(ticketData.flightAddress);

        // Get flight's details
        (SharedStructs.FlightDetails memory flightDetails) = flight.getDetails();

        if ((flightDetails.status == SharedStructs.FlightStatuses.OnTime || flightDetails.status == SharedStructs.FlightStatuses.Delayed) 
        && (flightDetails.actualDepartureDateTime - currentDateTime) < ticketCancellationWindow) {
            ticketData.agreementResult = "Ticket cancellation is not allowed on this flight because flight is scheduled to depart within 2 hours";
        } else {
            // Update the status and timestamp of the ticket, so that it will be available during account settlements.
            ticketData.cancelledDateTime = currentDateTime;
            ticketData.status = SharedStructs.TicketStatuses.Cancelled;
            (bool halt,,, string memory resultMessage) = settleTicketAccounts(flightDetails);
            if (halt) {
                ticketData.cancelledDateTime = 0;
                ticketData.status = SharedStructs.TicketStatuses.Open;
                ticketData.agreementResult = string(abi.encodePacked(resultMessage, ". Ticket cancellation aborted"));
            } if (bytes(resultMessage).length > 0) {
                ticketData.agreementResult = string(abi.encodePacked(resultMessage, ". Ticket cancelled successfully"));
            } else {
                ticketData.agreementResult = "Ticket cancelled successfully";
            }
        }
    }
    
    /**
     * @notice Settles the account for the associated ticket
     * @param flightDetails - Latest details of the flight
     */
    function settleAccounts(SharedStructs.FlightDetails memory flightDetails) external virtual {
        if (ticketData.status != SharedStructs.TicketStatuses.Settled) {        
            (,,, string memory resultMessage) = settleTicketAccounts(flightDetails);
            if (bytes(resultMessage).length > 0) {
                ticketData.agreementResult = string(abi.encodePacked(resultMessage, ". Ticket settled successfully"));
            } else {
                ticketData.agreementResult = "Ticket settled successfully";
            }
        } else {
            ticketData.agreementResult = string(abi.encodePacked("Ticket is already settled. ", SharedFuncs.uintToString(ticketData.paidToCustomer), 
            " wei were paid to customer while ", SharedFuncs.uintToString(ticketData.paidToAirline), " wei were paid to the airline"));
        }
    }

    /**
     * @notice Settles the account for the associated ticket
     * @param flightDetails - Latest details of the flight
     * @return Amount refunded to the customer
     * @return Amount paid to the airline
     * @return Summary of the operation
     */
    function settleTicketAccounts(SharedStructs.FlightDetails memory flightDetails) internal virtual returns(bool, uint256, uint256, string memory) {

        string memory message;
        uint256 chargeAmount;
        bool halt = false;
        uint256 refundAmount;

        // Calculate penalty amount
        (halt, chargeAmount, message) = calculateCharge(flightDetails);
        
        if (!halt) {
            // Calculate refund amount
            
            if (ticketData.amount < chargeAmount) {
                refundAmount = ticketData.amount;
            } else {
                refundAmount = ticketData.amount - chargeAmount;
            }

            // Get Escrow contract
            EscrowInterface escrow = EscrowInterface(ticketData.escrowContractAddress);

            if (refundAmount > 0) {
                escrow.withdraw(ticketData.buyer.buyerAddress, refundAmount);
                ticketData.paidToCustomer = refundAmount;
                if (bytes(message).length > 0) {
                    message = string(abi.encodePacked(message, ". ", SharedFuncs.uintToString(refundAmount), " refunded to the customer"));
                } else {
                    message = "Amount refunded to the customer";
                }
            }

            if (chargeAmount > 0) {

                address payable airlineWallet = AirlineInterface(flightDetails.airlineAddress).getWallet();
                escrow.withdraw(airlineWallet, chargeAmount);
                ticketData.paidToAirline = chargeAmount;
                if (bytes(message).length > 0) {
                    message = string(abi.encodePacked(message, ". ", SharedFuncs.uintToString(chargeAmount), " paid to the airline"));
                } else {
                    message = "Amount paid to the airline";
                }
            }

            ticketData.status = SharedStructs.TicketStatuses.Settled;
        }

        return (halt, refundAmount, chargeAmount, message);
    }

    /**
     * @notice Calcualtes the penalty amount for the associated ticket
     * @param flightDetails - Latest details of the flight
     * @return Amount to charge
     * @return Summary of the operation
     * @return Flag indcating if the settle process for the ticket should be halted
     */
    function calculateCharge(SharedStructs.FlightDetails memory flightDetails) internal virtual returns(bool, uint256, string memory);

}