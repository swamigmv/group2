// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title TicketAgreementBase
 * @dev Ticket agreement contract
 */
abstract contract TicketAgreementBase {
    
    SharedStructs.TicketData private ticketData;

    function settleAccounts() external virtual returns(bool);

}