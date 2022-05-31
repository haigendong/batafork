// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./Fund.sol";

contract BsmDevFund is Fund {
    uint256 public constant ALLOCATION = 3_000_000 ether; // 10%
    uint256 public constant VESTING_DURATION = 2 * 365 * 24 * 3600; // 2 years
    uint256 public constant VESTING_START = 1649926800; // 14th Apr 2022, 9AM UTC

    /*===================== VIEWS =====================*/

    function allocation() public pure override returns (uint256) {
        return ALLOCATION;
    }

    function vestingStart() public pure override returns (uint256) {
        return VESTING_START;
    }

    function vestingDuration() public pure override returns (uint256) {
        return VESTING_DURATION;
    }
}
