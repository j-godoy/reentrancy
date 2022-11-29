pragma solidity ^0.5.11;


contract Auction {
    uint public auctionStart;
    uint public biddingTime;
    address payable public beneficiary;
    uint public cont = 0;

    event Log(uint n, uint cont);
    bool public ended = false;
    address payable public highestBidder = address(0);
    uint public highestBid = 0;
    mapping(address => uint) public pendingReturns;

    constructor(uint _auctionStart, uint _biddingTime, address payable _beneficiary) public {
        auctionStart = _auctionStart;
        biddingTime = _biddingTime;
        beneficiary = _beneficiary;
    }

    function get_blocknumber() public view returns (uint) {
        return block.number;
    }

    function get_bid_amount() public view returns (uint) {
        return pendingReturns[msg.sender];
    }


    function Bid() public payable {
        uint end = auctionStart + biddingTime;
        if(end < block.number || ended) {
            revert();
        }
        else {
            if(msg.value <= highestBid) {
                revert();
            }
            else {
                pendingReturns[highestBidder] += highestBid; 
                highestBidder = msg.sender;
                highestBid = msg.value;
            }
        }
    }

    function Withdraw() public {
        cont++;
        if(pendingReturns[msg.sender] != 0) {
            uint pr = pendingReturns[msg.sender];
            //emit Log(pr, cont);
            (bool sent,) = msg.sender.call.value(pr)("");
            require(sent);
            pendingReturns[msg.sender] = 0;
        }
        else {
            revert();
        }
        emit Log(block.number, cont);
        cont--;
    }

    function AuctionEnd() public {
        uint end = auctionStart + biddingTime;
        if(block.number <= end || ended) {
            revert();
        }
        else {
            ended = true;
            beneficiary.transfer(highestBid);
        }
    }
}