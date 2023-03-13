pragma solidity 0.8.19;
contract MappingAndArrays {

    uint[3] fixedArray = [100,150,200];
    uint[] dynamicArray = [100,150,200,300];
    uint16[] smallArray = [1,2,3];
    
    mapping(uint => uint) myMap;
    mapping(uint key1 => mapping(uint key2 => uint value)) myNestedMap;
    mapping (address => uint[]) public addressToList;

    constructor(){
        myMap[1] = 100;
        myNestedMap[1][2] = 200;
        addressToList[msg.sender] = [1,2,3];
    }

    function readFixedArray(uint index) external view returns (uint ret) {
        assembly {
            let slot := fixedArray.slot
            ret := sload(add(slot, index))
        }
    }

    function writeToFixedArray(uint index, uint value) external {
        assembly {
            let slot := fixedArray.slot
            sstore(add(slot, index), value)
        }
    }

    function readDynamicArrayLength() external view returns (uint ret) {
        assembly {
            ret := sload(dynamicArray.slot)
        }
    }

    function readDynamicArray(uint index) external view returns (uint ret) {
        uint slot;

        assembly {
            slot:= dynamicArray.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            ret := sload(add(location, index))
        }
    }

    function readSmallArrayLength() external view returns (uint ret) {
        assembly {
            ret := sload(smallArray.slot)
        }
    }

    function readSmallArray(uint index) external view returns (bytes32 ret) {
        uint slot;

        assembly {
            slot:= dynamicArray.slot
        }

        bytes32 location = keccak256(abi.encode(slot));

        assembly {
            ret := sload(add(location, index))
        }
    }

    function getMappingValue(uint key) external view returns (uint ret) {
        uint slot;
        assembly {
            slot := myMap.slot
        }

        // Key, Slot
        bytes32 location = keccak256(abi.encode(key, uint(slot)));

        assembly {
            ret := sload(location)
        }
    }

    function getNestedMapping(uint key1, uint key2) external view returns (uint ret) {
        uint slot;
        assembly {
            slot := myNestedMap.slot
        }

        // Key 2, Key 1, Slot
        bytes32 location = keccak256(abi.encode(key2, keccak256(abi.encode(key1, uint(slot)))));

        assembly {
            ret := sload(location)
        }
    }

    function lengthOfDynamicMapping() external view returns (uint ret) {
        uint slot;
        assembly {
            slot := addressToList.slot
        }

        // Address, Slot
        bytes32 location = keccak256(abi.encode(msg.sender, uint(slot)));

        assembly {
            ret := sload(location)
        }
    }

    function getDynamicMapping(uint index) external view returns (uint ret) {
        uint slot;
        assembly {
            slot := addressToList.slot
        }

        // Hash(Address, Slot)
        bytes32 location = keccak256(abi.encode(keccak256(abi.encode(msg.sender, uint(slot)))));

        assembly {
            ret := sload(add(location, index))
        }
    }
}