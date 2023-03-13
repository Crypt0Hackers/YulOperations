// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicMaths {
    function isPrime(uint x) external pure returns (bool p) {
        p=true;
        
        assembly {
            let halfX := add(div(x, 2), 1)
            for {let i := 2} lt(i, halfX) {i := add(i, 1)} {
                if eq(mod(x, i), 0) {
                    p := 0
                    break
                }
            }
        }
    }

    function isEven(uint x) external pure returns (bool p) {
        assembly {
            p := iszero(mod(x, 2))
        }
    }

    function max(uint x, uint y) external pure returns (uint _max) {
        assembly {
            if gt(x, y) {
                _max := x
            }
            if iszero(gt(x, y)) {
                _max := y
            }
        }
    }    
}
