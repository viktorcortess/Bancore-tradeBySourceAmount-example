// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

import "./bancor/IBancorNetwork.sol";
import "./bancor/Token.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract testContract {
    using SafeERC20 for IERC20;
    address private constant Bancor_Network = 0xeEF417e1D5CC832e619ae18D2F140De2999dD4fB;
    IBancorNetwork public constant swapRouter =
        IBancorNetwork(0xeEF417e1D5CC832e619ae18D2F140De2999dD4fB);
    
        function toIERC20(Token token) internal pure returns (IERC20) {
        return IERC20(address(token));
    }

    function swap(
        Token TokenA,
        Token TokenB,
        uint256 _amountIn
    ) external returns (uint256) {
        IERC20 tokenA = toIERC20(TokenA);
        
       IERC20(tokenA).safeApprove(Bancor_Network, _amountIn);
     
        console.log(_amountIn);
      uint256 amountSwap1 = swapRouter.tradeBySourceAmount(
        TokenA,
        TokenB,
        _amountIn,
        1,
        block.timestamp ,
        address(this) //address(this) doesn't receive ETH
      );
      
      return amountSwap1;
    }


}