// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./Fund.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "./BsmDaoFund.sol";

contract BsmDaoFundFixed is Ownable {
    BsmDaoFund public daoFundOriginal;
    uint256 public claimedAmount;

    uint256 public constant ALLOCATION = 3_000_000 ether; // 10%
    uint256 public constant VESTING_DURATION = 3 * 365 * 24 * 3600; // 3 years
    uint256 public constant VESTING_START = 1649926800; // 14th Apr 2022, 9AM UTC

    /*===================== CONSTRUCTOR =====================*/

    constructor(address _daoFund) {
        require(_daoFund != address(0), "BsmDaoFundFixed::constructor: Invalid address");
        daoFundOriginal = BsmDaoFund(_daoFund);
    }

    /*===================== VIEWS =====================*/

    function currentBalance() public view returns (uint256) {
        return daoFundOriginal.currentBalance();
    }

    function allocation() public pure returns (uint256) {
        return ALLOCATION;
    }

    function vestingStart() public pure returns (uint256) {
        return VESTING_START;
    }

    function vestingDuration() public pure returns (uint256) {
        return VESTING_DURATION;
    }

    function vestedBalance() public view returns (uint256) {
        uint256 _allocation = allocation();
        uint256 _start = vestingStart();
        uint256 _duration = vestingDuration();
        if (block.timestamp <= _start) {
            return 0;
        }
        if (block.timestamp > _start + _duration) {
            return _allocation;
        }
        return (_allocation * (block.timestamp - _start)) / _duration;
    }

    function claimable() public view returns (uint256) {
        return vestedBalance() - claimedAmount;
    }

    /*===================== MUTATIVE =====================*/
    function transfer(address receiver, uint256 amount) external onlyOwner {
        require(receiver != address(0), "Fund::transfer: Invalid address");
        require(amount > 0, "Fund::transfer: Invalid amount");
        require(amount <= claimable(), "Fund::transfer: > vestedAmount");

        claimedAmount = claimedAmount + amount;
        daoFundOriginal.transfer(receiver, amount);
    }
}
