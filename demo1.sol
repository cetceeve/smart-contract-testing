// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
contract Counter {
    uint256 counter = 0;

    function inc() public {
        counter += 1;
    }

    function dec() public {
        counter -= 1;
    }
}

