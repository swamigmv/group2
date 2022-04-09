// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

import "../libraries/SharedStructs.sol";

/**
 * @title CustomerInterface
 * @dev Interface for the customer
 */
interface CustomerInterface {
    function buyTicket(string calldata flightNumber, uint256 departureDateTime, uint16 numberOfSeats) external returns (address, string memory);
    function cancelTicket(address ticketAddress) external payable returns (address, string memory);
    function settleTicket(address ticketAddress) external payable returns (address, string memory);
}