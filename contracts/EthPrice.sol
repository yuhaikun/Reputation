pragma solidity 0.5.0;

import "./provableAPI.sol";

contract EthPrice is usingProvable {

    uint256 public ethPriceCents;

    event LogNewEthPrice(uint256 _priceInCents);
    event LogNewProvableQuery(string _description);

    constructor()
        public
    {
        OAR = OracleAddrResolverI(0x6f485C8BF6fc43eA212E93BBF8ce046C7f1cb475);
        fetchEthPriceViaProvable();
    }

    function fetchEthPriceViaProvable()
        public
        payable
    {
        emit LogNewProvableQuery("Provable query in-flight!");
        provable_query(
            "URL",
            "json(https://gateway.ipfs.io/ipfs/QmTQfazmn4sXcte6TjVmY7NkxNqj8meqjpXxtC2xuzg6cA/1.json).name"
        );
    }

    function __callback(
        bytes32 _queryID,
        string memory _result,
        bytes memory _proof
    )
        public
    {
        require(msg.sender == provable_cbAddress());
        ethPriceCents = parseInt(_result, 2);
        emit LogNewEthPrice(ethPriceCents);
    }

    function() external payable{

    }
}
