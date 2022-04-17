// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title Interface for Ticket contract
 */
interface TicketInterface {
    /**
     * @notice Cancels the ticket
     * @return Summary of the operation 
     */
    function cancel() external payable returns (string memory);

    /**
     * @notice Settles accounts associated with the ticket
     * @return Summary of the operation 
     */
    function settleAccounts() external payable returns (string memory);

    /**
     * @notice Gets the status of the ticket
     * @return Status of the ticket
     */
    function getStatus() external returns (SharedStructs.TicketStatuses);
}