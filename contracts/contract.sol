pragma solidity ^0.5.0;

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

	function Auction(address _owner, uint _startBlock, uint _endBlock, string memory _itemLink) public {
	    assert(_startBlock >= _endBlock);
	    assert(_startBlock < block.number);
	    //assert(_owner == 0);

	    owner = _owner;
	    startBlock = _startBlock;
	    endBlock = _endBlock;
	    itemLink = _itemLink;
	}

	function placeBid() public notOwner notHighestBidder notZero bidOnline notDouble notHighestBid payable{
		highestBid = fundsByBidder[msg.sender] + msg.value;
		fundsByBidder[msg.sender] = highestBid;

	}

	modifier notOwner {
		assert(msg.sender == owner) ;
		_;
	}
	modifier notHighestBidder {
		assert(msg.sender == highestBidder);
		_;
	}
	modifier notZero {
		assert(msg.value == 0);
		_;
	}
	modifier bidOnline {
		assert(block.number < startBlock || block.number > endBlock);
		_;
	}
	modifier notDouble {
		assert(fundsByBidder[msg.sender] + msg.value == 2 * highestBid);
		_;
	}
	modifier notHighestBid {
		assert(fundsByBidder[msg.sender] + msg.value <= highestBid);
		_;
	}

}
