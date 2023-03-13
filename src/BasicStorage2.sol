contract BasicStorage2 {
    
    uint128 public A = 1; // 16 bytes
    uint96 public B = 2; // 12 bytes
    uint16 public C = 4; // 2 bytes
    uint8 public D = 8; // 1 byte
    bool public E = true; // 1 byte

    // Slot 0 = 32 bytes

    function loadYulSlotInBytes(uint slot) external view returns (bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function getOffsetC() external pure returns (uint slot, uint ret) {
        assembly {
            slot := C.slot
            ret := C.offset
        }
    }

    function readC() external view returns (uint256 ret) {
        assembly {
            let slot := sload(C.slot)
            let offset := C.offset
            let shifted := shr(mul(offset, 8), slot) // Bit-shift right by offset * 8 (bytes)
            ret := and(0xffff, shifted) // Bitwise AND with 0xffff (16 bits)
        }
    }

    function writeToC(uint16 newC) external {

        assembly {          //CCCC - 16 bits
            // slot 0 - 0x0108000400000000000000000000000200000000000000000000000000000001
            let slot := C.slot
            let loadC := sload(slot)

            let clearedC := and(
                loadC,
                0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff
            )

            let shiftedC := shl(
                mul(C.offset, 8),
                newC
            )

            let newVal := or(
                clearedC,
                shiftedC
            )   

            sstore(slot, newVal)
        }

    }
}