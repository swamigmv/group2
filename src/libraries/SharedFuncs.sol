// SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.8.6 < 0.9.0;

/**
 * @title Library containing the shared functions.
 */
library SharedFuncs {

    /**
     * @notice Gets the current date time.
     * @return The date time value to be used as current date time.
     */
   function getCurrentDateTime() public view returns (uint256) {
       return block.timestamp;
   }

}