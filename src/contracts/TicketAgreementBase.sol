// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";
import "../libraries/SharedFuncs.sol";
import "../interfaces/FlightInterface.sol";

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
    function cancelTicket() external payable virtual {

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
            (, , string memory resultMessage) = settleTicketAccounts(flightDetails);
            if (bytes(resultMessage).length > 0) {
                ticketData.agreementResult = string(abi.encodePacked(resultMessage, ". Ticket cancelled successfully"));
            } else {
                ticketData.agreementResult = "Ticket cancelled successfully";
            }
        }
    }
    
    /**
     * @notice Settles the account for the associated ticket
     * @param flightDetails - Latest details of the flight
     * @return Amount refunded to the customer
     * @return Amount paid to the airline
     * @return Summary of the operation
     */
    function settleAccounts(SharedStructs.FlightDetails calldata flightDetails) external payable virtual returns(uint256, uint256, string memory) {
        if (ticketData.status != SharedStructs.TicketStatuses.Settled) {        
            return settleTicketAccounts(flightDetails);
        } else {
            return (ticketData.paidToCustomer, ticketData.paidToAirline, "Ticket is already settled");
        }
    }

    /**
     * @notice Settles the account for the associated ticket
     * @param flightDetails - Latest details of the flight
     * @return Amount refunded to the customer
     * @return Amount paid to the airline
     * @return Summary of the operation
     */
    function settleTicketAccounts(SharedStructs.FlightDetails memory flightDetails) internal virtual returns(uint256, uint256, string memory) {

        string memory message;
        uint256 chargeAmount;
        
        // Calculate penalty amount
        (chargeAmount, message) = calculateCharge(flightDetails);
        
        // Calculate refund amount
        uint256 refundAmount = ticketData.amount - chargeAmount;

        if (refundAmount > 0) {
            //ticketData.buyer.buyerAddress.transfer(refundAmount);
            ticketData.paidToCustomer = refundAmount;
            if (bytes(message).length > 0) {
                message = string(abi.encodePacked(message, ". Amount refunded to the customer"));
            } else {
                message = "Amount refunded to the customer";
            }
        }

        if (chargeAmount > 0) {
            //flightDetails.airlineAddress.transfer(refundAmount);
            ticketData.paidToAirline = chargeAmount;
            if (bytes(message).length > 0) {
                message = string(abi.encodePacked(message, ". Amount paid to the airline"));
            } else {
                message = "Amount paid to the airline";
            }
        }

        return (refundAmount, chargeAmount, message);
    }

    /**
     * @notice Calcualtes the penalty amount for the associated ticket
     * @param flightDetails - Latest details of the flight
     * @return Amount to charge
     * @return Summary of the operation
     */
    function calculateCharge(SharedStructs.FlightDetails memory flightDetails) internal virtual returns(uint256, string memory);

}