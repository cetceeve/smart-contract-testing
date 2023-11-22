// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Ownable {
    address public owner = msg.sender;

    function Owner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    modifier onlyOwner() {
        require(owner == msg.sender);
        _;
    }
}

contract Pausable is Ownable {
    bool private _paused;

    function paused() public view returns (bool) {
        return _paused;
    }

    function pause() public onlyOwner {
        _paused = true;
    }

    function resume() public onlyOwner {
        _paused = false;
    }

    modifier whenNotPaused() {
        require(!_paused, "Pausable: Contract is paused.");
        _;
    }
}

contract Token is Ownable, Pausable {
    mapping(address => uint256) public balances;

    function transfer(address to, uint256 value) public whenNotPaused {
        balances[msg.sender] -= value;
        balances[to] += value;
    }
}

contract Test is Token {
    constructor() {
        balances[address(0x10000)] = 10000;

        pause();
        owner = address(0);
    }

    function echidna_balance_should_not_change() public view returns (bool) {
        return balances[address(0x10000)] == 10000; 
    }
}