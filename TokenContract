// SPDX-License-Identifier: Unlicenced
pragma solidity 0.8.18;
contract TokenContract {
    address public owner;
    struct Receivers {
        string name;
        uint256 tokens;
    }

    mapping(address => Receivers) public users;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    constructor() {
        owner = msg.sender;
        users[owner].tokens = 100;
    }

    function double(uint _value) public pure returns (uint) {
        return _value * 2;
    }

    function register(string memory _name) public {
        users[msg.sender].name = _name;
    }

    function giveToken(address _receiver, uint256 _amount) public onlyOwner {
        require(users[owner].tokens >= _amount);
        users[owner].tokens -= _amount;
        users[_receiver].tokens += _amount;
    }

    function buyToken() external payable {
        uint precio = 5 ether;

        require(msg.value == precio, "Ether sent is not enough"); //comprobar si la cantidad de Ether enviada es suficiente
        require(
            users[owner].tokens >= (msg.value / precio),
            "Owner tokens are not enough"
        ); //Comprobar la cantidad de tokens del ownner

        //transferencia
        users[owner].tokens -= (msg.value / precio);
        users[msg.sender].tokens += (msg.value / precio);
    }
}
