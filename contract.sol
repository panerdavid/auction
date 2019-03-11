pragma solidity ^0.4.25

contract auction {
	// static
	address public owner;
	uint public startBlock;
	uint public endBlock;
	string public itemLink;

	// state
	address public highestBidder;
	mapping(address => uint256) public fundsByBidder;
	uint public highestBid;

	constructor Auction(address _owner, uint _startBlock, uint _endBlock, string _itemLink) {
	    if (_startBlock >= _endBlock) throw;
	    if (_startBlock < block.number) throw;
	    if (_owner == 0) throw;

	    owner = _owner;
	    startBlock = _startBlock;
	    endBlock = _endBlock;
	    itemLink = _itemLink;
	}

	function payable notOwner notHighestBidder notZero bidOnline notDouble notHighestBid placeBid() {
		highestBid = fundsByBidder[msg.sender] + msg.value;
		fundsByBidder[msg.sender] = highestBid

	}

	modifier notOwner {
		if (msg.sender == owner) throw;
		_;
	}
	modifier notHighestBidder {
		if (msg.sender == highestBidder) throw;
		_;
	}
	modifier notZero {
		if (msg.value == 0) throw;
		_;
	}
	modifier bidOnline {
		if (block.number < startBlock || block.number > endBlock) throw;
		_;
	}
	modifier notDouble {
		if (fundsByBidder[msg.sender] + msg.value == 2 * highestBid) throw;
		_;
	}
	modifier notHighestBid {
		if (fundsByBidder[msg.sender] + msg.value <= highestBid) throw;
		_;
	}

}