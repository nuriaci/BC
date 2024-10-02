// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./access/Ownable.sol"; 

contract MyContractEjemplo is Ownable {

    mapping(address => bool) public users;
    address[] public userList;
    
    uint256 public userCount; 

    constructor() Ownable(msg.sender) {}

    
    function Registrar(uint256 _userCount) public onlyOwner {
        require(_userCount > 0, "El numero de usuarios no es valido"); 
 
        for (uint256 i = 0; i < _userCount; i++) {
            address newUser = address(uint160(uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, i)))));
            users[newUser] = true; // Marca al nuevo usuario como registrado
            userList.push(newUser); // Agrega al nuevo usuario a la lista
        }
    }


    function isUsuario(address user) public view returns (bool) {
        return users[user];
    }

    function getUsuarios() public view returns (address[] memory) {
        return userList;
    }
}
