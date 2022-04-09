// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

import "./TicketAgreementBase.sol";

/**
 * @title TicketAgreementV202204
 * @dev Ticket agreement contract version 2022.04
 */
contract TicketAgreementV202204 is TicketAgreementBase {
    
    SharedStructs.TicketData private ticketData;

    function settleAccounts() external override returns(bool) {
        return true;
    }

}