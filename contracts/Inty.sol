pragma solidity ^0.5.0;

import "./ERC20Pausable.sol";
import "openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "openzeppelin-solidity/contracts/math/SafeMath.sol";

contract Inty is ERC20Pausable, Ownable
{

    string public symbol = "ITM";
    uint8 public decimals = 18;
    mapping (address => uint256) private _frozenBalances;
    using SafeMath for uint256;
    

    constructor() public
    {
        _mint(owner(), 33000000 * 10 ** (uint256)(decimals));
    }

    function bulkTransfer(address[] memory recipients, uint256[] memory amounts) public onlyOwner
    {
        require(recipients.length == amounts.length, "Addresses and amounts arrays are not equal");

        for (uint256 i = 0; i < recipients.length; ++i)
        {
            require(recipients[i] != address(0), "One of the addresses is null address");
            _transfer(owner(), recipients[i], amounts[i]);
        }
    }

    function freeze(address token_holder, uint256 amount) public onlyOwner
    {
        require(token_holder != address(0), "token_holder is null address");
        require(amount <= _balances[token_holder], "No enough balance to freeze");
        _balances[token_holder] = _balances[token_holder].sub(amount);
        _frozenBalances[token_holder] = _frozenBalances[token_holder].add(amount);
    }

    function unfreeze(address token_holder, uint256 amount) public onlyOwner
    {
        require(token_holder != address(0), "token_holder is null address");
        require(amount <= _frozenBalances[token_holder], "No enough frozen balance to unfreeze");
        _frozenBalances[token_holder] = _frozenBalances[token_holder].sub(amount);
        _balances[token_holder] = _balances[token_holder].add(amount);
    }

    function burn(uint256 amount) public onlyOwner
    {
        _burn(msg.sender, amount);
    }

    function balanceOfFrozen(address token_holder) public view returns (uint256)
    {
        return _frozenBalances[token_holder];
    }
}