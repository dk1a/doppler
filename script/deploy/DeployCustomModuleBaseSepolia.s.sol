// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import { Script, console } from "forge-std/Script.sol";
import { ChainIds } from "script/ChainIds.sol";
import { UniswapV4Initializer, DopplerDeployer, IPoolManager } from "src/UniswapV4Initializer.sol";

contract DeployCustomModuleBaseSepolia is Script {
    function run() public {
        require(ChainIds.BASE_SEPOLIA == block.chainid, "Invalid chainId");
        console.log(unicode"🚀 Deploying on chain %s with sender %s...", vm.toString(block.chainid), msg.sender);

        address airlock = 0x3411306Ce66c9469BFF1535BA955503c4Bde1C6e;
        address poolManager = 0x05E73354cFDd6745C338b50BcFDfA3Aa6fA03408;

        vm.startBroadcast();
        DopplerDeployer dopplerDeployer = new DopplerDeployer(IPoolManager(poolManager));
        UniswapV4Initializer uniswapV4Initializer =
            new UniswapV4Initializer(airlock, IPoolManager(poolManager), dopplerDeployer);
        vm.stopBroadcast();
    }
}
