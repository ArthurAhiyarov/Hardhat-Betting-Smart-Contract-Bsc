//SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract BettingSM is Ownable {

    AggregatorV3Interface internal priceFeed;

    uint256 public ownerFeeForBidCreation;
    uint256 public bidCreatorFee; // creator gets it only if his prediction is correct
    uint256 public minDuration = 3 days;

    string[] currencyArray;

    struct Bettor {
        address addr;
        bool prediction;
        uint256 betAmt;
    }

    struct Bid {

        address creator;
        string title;
        string currency;
        uint256 potentialPrice;
        uint256 actualPrice;
        uint256 bidDeadline;
        uint256 balance;
        // uint256 newPrice;
        // mapping(address => bool) bettorToPrediction;
        mapping(address => Bettor) bettors;

    }

    mapping(string => Bid) s_bids;



    constructor(uint256 memory _ownerFee) {
        ownerFee = _ownerFee;
    }

    function createBid(string memory _title, string memory _currency, uint256 _potentialPrice, uint256 _duration) public payable {

        require(s_bids[_title].bidDeadline == 0, "There is already a Bid with such title");
        require((bytes32(_title)).length > 0, "Title must have at least 1 symbol");
        require(_potencialPrice > 0, "We don't work with the price of zero");
        require(msg.value >= ownerFeeForBidCreation, "Need more gold!");
        require(_duration > minDuration, "Should be longer than minDuration");



        Bid storage newBid = s_bids[_title];

        newBid.creator = msg.sender;
        newBid.title = _title;
        newBid.potentialPrice = _potentialPrice;
        newBid.bidDeadline = block.timestamp + duration;
        Bettor storage newBettor = newBid.bettors[msg.sender];
        newBettor.addr = msg.sender;
        newBettor.prediction = true;
        newBettor.betAmt = msg.value;
        
    }

    function makeBid(string memory _title, bool memory _prediction) public payable {
        require(s_bids[_title].potentialPrice > 0, "There is no such ballot");

        Bid storage bid = s_bids[_title];
        // if (bid.bettorToBidAmt == 0) {
        //     if (_prediction == false) {
        //         bid.bettorsAgainst.push(msg.sender);
        //     } else {Bid storage newBid = s_bids[_title];
        //         bid.bettorsFor.push(msg.sender);
        //         }
        // }
    } 



}
