// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.6;

library SharedStructs {
    /**
    * @title FlightDetails
    * @dev Structure for the flight details
    */
    struct FlightDetails {
        string flightNumber;
        uint256 departureDateTime; 
    }

    /**
    * @title Buyer
    * @dev Structure for the buyer details
    */
    struct Buyer {
        string name;
        address buyerAddress;
    }
}