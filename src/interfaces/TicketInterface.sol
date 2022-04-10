// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title TicketInterface
 * @dev Interface for the ticket
 */
interface TicketInterface {
    function cancel() external payable returns (address, string memory);
    function settleAccounts() external payable returns (address, string memory);
    function getStatus() external returns (SharedStructs.TicketStatuses);
}