// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "./TicketAgreementBase.sol";

/**
 * @title TicketAgreementV202204
 * @dev Ticket agreement contract version 2022.04
 */
contract TicketAgreementV202204 is TicketAgreementBase {
    
    SharedStructs.TicketData private ticketData;

    function settleAccounts() external override pure returns(bool) {
        /* TODO: Apply penelty and refund policies to calculate the amount to be paid to the buyer and to the airline.
           Then settle both accounts. */
        return true;
    }

}