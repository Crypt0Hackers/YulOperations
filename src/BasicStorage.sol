// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BasicStorage {

    // sload(slot) 
    // sstore(slot, value)

    uint x = 10;
    uint y = 20;
    uint z = 30;

    function getXinYul() external view returns (uint ret) {
        assembly {
            ret := sload(x.slot)
        }
    }

    function getXSlot() external pure returns(uint ret) {
        assembly {
            ret := x.slot
        }
    }

    function getSlot(uint slot) external view returns (uint ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function storeInYul(uint slot, uint value) external {
        assembly {
            sstore(slot, value)
        }
    }
}