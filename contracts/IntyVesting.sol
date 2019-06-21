pragma solidity ^0.5.0;

import "openzeppelin-solidity/contracts/drafts/TokenVesting.sol";


contract IntyVesting is TokenVesting
{
    constructor(address beneficiary, uint256 start, uint256 cliffDuration, uint256 duration) public
    TokenVesting(beneficiary, start, cliffDuration, duration, false)
    {
        
    }
}