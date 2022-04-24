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

   /**
     * @notice Coverts uint value into string.
     * @return String convertion of the value.
     */
   function uintToString(uint v) public pure returns (string memory) {
      uint maxlength = 100;
      bytes memory reversed = new bytes(maxlength);
      uint i = 0;
      while (v != 0) {
         uint remainder = v % 10;
         v = v / 10;
         reversed[i++] = bytes1(uint8(48 + remainder));
      }
      bytes memory s = new bytes(i); // i + 1 is inefficient
      for (uint j = 0; j < i; j++) {
         s[j] = reversed[i - j - 1]; // to avoid the off-by-one error
      }
      string memory str = string(s);  // memory isn't implicitly convertible to storage
      return str;
   }

}