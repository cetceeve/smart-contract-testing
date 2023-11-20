// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract Ownable {
    address public owner = msg.sender;

    function Owner() public onlyOwner {
        owner = msg.sender;
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
    address public user = address(0x10000);

    constructor() {
        balances[user] = 10000;

        pause();
        owner = address(0);
    }

    function echidna_locked_balances_on_pause() public view returns (bool) {
        return balances[user] == 10000;
    }
}
