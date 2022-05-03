// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../contracts/TicketAgreementBase.sol";
import "../libraries/SharedFuncs.sol";
import "../interfaces/FlightInterface.sol";

/**
 * @title Ticket agreement version 202204
 */
contract TicketAgreementV202204 is TicketAgreementBase {

    /**
     * @notice Calcualtes the penalty amount for the associated ticket
     * @param flightDetails - Flight's latest details
     * @return Flag indcating if the settle process for the ticket should be halted
     * @return Amount to charge
     * @return Summary of the operation
     */
    function calculateCharge(SharedStructs.FlightDetails memory flightDetails) internal override view returns(bool, uint256, string memory) {
        
        string memory message;
        uint256 chargeAmount;
        bool halt = false;

        // If ticket status is settled, then return existing penalty amount
        if (ticketData.status == SharedStructs.TicketStatuses.Settled) {
            chargeAmount = ticketData.paidToAirline;
            message = "Ticket is already settled";
        } else if (ticketData.status == SharedStructs.TicketStatuses.Cancelled) {
            // If ticket is cancelled, then depending on the time difference between flight departure time and cancellation time
            // calculate the penalty
            uint256 cancellationTimeDiff;
            if (ticketData.cancelledDateTime < flightDetails.actualDepartureDateTime) {
                cancellationTimeDiff = flightDetails.actualDepartureDateTime - ticketData.cancelledDateTime;
            } else {
                cancellationTimeDiff = 0;
            }

            if (cancellationTimeDiff > 48 hours) {
                // If ticket cancelled before 48 hours then refund 80%
                chargeAmount = (ticketData.amount * 20) / 100;
                message = "Ticket is cancelled 48 hours before departure hence 20% amount is charged. Rest will be refunded";
            } else if (cancellationTimeDiff > 24 hours) {
                // If ticket cancelled before 24 hours then refund 50%
                chargeAmount = (ticketData.amount * 50) / 100;
                message = "Ticket is cancelled 24 hours before departure hence 50% amount is charged. Rest will be refunded";
            } else if (cancellationTimeDiff > 12 hours) {
                // If ticket cancelled before 12 hours then refund 30%
                chargeAmount = (ticketData.amount * 70) / 100;
                message = "Ticket is cancelled 12 hours before departure hence 70% amount is charged. Rest will be refunded";
            } else if (cancellationTimeDiff > 6 hours) {
                // If ticket cancelled before 6 hours then refund 10%
                chargeAmount = (ticketData.amount * 90) / 100;
                message = "Ticket is cancelled 6 hours before departure hence 90% amount is charged. Rest will be refunded";
            } else if (cancellationTimeDiff > 2 hours) {
                // If ticket cancelled before 2 hours then refund 5%
                chargeAmount = (ticketData.amount * 95) / 100;
                message = "Ticket is cancelled 2 hours before departure hence 95% amount is charged. Rest will be refunded";
            } else {
                // Charge full amount
                chargeAmount = ticketData.amount;
                message = "Ticket is cancelled less than 2 hours before departure hence full amount is charged. No refund";
            }

        } else {
            // If ticket is open, then depending on flight's status and departure time calculate the charge
            if (flightDetails.status == SharedStructs.FlightStatuses.Cancelled) {
                // If flight is cancelled then no charge
                chargeAmount = 0;
            } else if (flightDetails.status != SharedStructs.FlightStatuses.Departed) {
                // Check if the flight is departed but it's status is not updated
                uint256 dateTimeNow = SharedFuncs.getCurrentDateTime();
                if (dateTimeNow > flightDetails.actualDepartureDateTime && (dateTimeNow - flightDetails.actualDepartureDateTime) > 2 hours) {
                    // No updates are done in the flight status until 2 hours after departure then charge no amount
                    chargeAmount = 0;
                } else {
                    // Ticket cannot be settle as of now
                    message = "The ticket can be settled after 2 hours of departure";
                    halt = true;
                }
            } else {
                // If flight is not cancelled then charge depending on the difference between actual departure and 
                // original scheduled departure
                uint256 departureDelay;
                if (flightDetails.originalDepartureDateTime < flightDetails.actualDepartureDateTime) {
                    departureDelay = flightDetails.actualDepartureDateTime - flightDetails.originalDepartureDateTime;
                } else {
                    departureDelay = 0;
                }

                if (departureDelay == 0) {
                    // No delay then charge full
                    chargeAmount = ticketData.amount;
                    message = "No delay in flight departure hence full amount is charged. No refund";
                } else if (departureDelay <= 2 hours) {
                    // If delay is <= 2 hours then charge 98%
                    chargeAmount = (ticketData.amount * 98) / 100;
                    message = "Delay in flight departure is <= 2 hours hence 98% amount is charged. Rest will be refunded";
                } else if (departureDelay <= 6 hours) {
                    // If delay is <= 6 hours then charge 90%
                    chargeAmount = (ticketData.amount * 90) / 100;
                    message = "Delay in flight departure is <= 6 hours hence 90% amount is charged. Rest will be refunded";
                } else {
                    // If delay is > 6 hours then charge 80%
                    chargeAmount = (ticketData.amount * 80) / 100;
                    message = "Delay in flight departure is > 6 hours hence 80% amount is charged. Rest will be refunded";
                }
            }
        }

        return (halt, chargeAmount, message);

    }

}