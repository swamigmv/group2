//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

/**
 * Request testnet LINK and ETH here: https://faucets.chain.link/
 * Find information on LINK Token Contracts and get the latest ETH and LINK faucets here: https://docs.chain.link/docs/link-token-contracts/
 */

/**
 * @notice DO NOT USE THIS CODE IN PRODUCTION. This is an example contract.
 */
contract GenericLargeResponse is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  // variable bytes returned in a signle oracle response
  bytes public data;
  string public image_url;
  address public manager;

  event SomeResponse(string response);

  /**
   * @notice Initialize the link token and target oracle
   * @dev The oracle address must be an Operator contract for multiword response
   *
   *
   * Kovan Testnet details:
   * Link Token: 0xa36085F69e2889c224210F603D836748e7dC0088
   * Oracle: 0xc57B33452b4F7BB189bB5AfaE9cc4aBa1f7a4FD8 (Chainlink DevRel)
   *
   */
  constructor()  payable {
    setChainlinkToken(address(0xa36085F69e2889c224210F603D836748e7dC0088));
    manager = msg.sender;
  }

  /**
   * @notice Request variable bytes from the oracle
   */
  function requestBytes() external payable
  
  //  public
  {
    bytes32 specId = "d5270d1c311941d0b08bead21fea7747";
    uint256 payment = msg.value;
    //require(msg.value == 100000000000000000, "Can perform this operation");
    Chainlink.Request memory req = buildChainlinkRequest(specId, address(this), this.fulfillBytes.selector);
    //require(msg.value == 100000000000000000, "Can't perform this operation");
    req.add("get","https://api.aviationstack.com/v1/flights?access_key=10fe6d902318b52930a454c88242555c");
    req.add("path", "v1/flights");
    //sendOperatorRequest(req, payment);
    sendChainlinkRequestTo(address(0xc57B33452b4F7BB189bB5AfaE9cc4aBa1f7a4FD8), req, payment);

  }

  function withdraw () payable public {
    payable(address(0xa36085F69e2889c224210F603D836748e7dC0088)).transfer(msg.value);
}

  
	function getBalance() external view returns (uint256 balance) {
         balance = (address(this).balance);
    }


  event RequestFulfilled(
    bytes32 indexed requestId,
    bytes indexed data
  );

  /**
   * @notice Fulfillment function for variable bytes
   * @dev This is called by the oracle. recordChainlinkFulfillment must be used.
   */
  function fulfillBytes(
    bytes32 requestId,
    bytes memory bytesData
  )
 
    public
    recordChainlinkFulfillment(requestId)
  {
    emit RequestFulfilled(requestId, bytesData);
    data = bytesData;
    image_url = string(data);
  }

}
