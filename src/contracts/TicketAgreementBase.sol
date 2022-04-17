// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title Base contract for all ticket agreements
 */
abstract contract TicketAgreementBase {
    
    SharedStructs.TicketData private ticketData;

    /**
     * @notice Settles the account for the associated ticket
     * @return True on success
     * @return Summary of the operation
     */
    function settleAccounts() external virtual returns(bool, string memory);

}