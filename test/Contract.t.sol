// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ERC721Dropping.sol";

contract ContractTest is Test {
    ERC721Dropping erc721Dropping;
    address testAddr = makeAddr("alice");

    function setUp() public {
        erc721Dropping = new ERC721Dropping(
            "MintTest",
            "MT",
            testAddr,
            1000,
            testAddr
        );
    }

    function testDropWIthZeroTokens() public {
        vm.expectRevert(
            "ERC721Dropping: minting amount must be greater than 0"
        );
        erc721Dropping.mint(testAddr, 0);
        assertEq(erc721Dropping.balanceOf(testAddr), 0);
    }

    function testDropWithMintingOneToken() public {
        erc721Dropping.mint(testAddr, 1);
        assertEq(erc721Dropping.balanceOf(testAddr), 1);
    }

    function testDropWithMintingRandomToken(uint16 random) public {
        erc721Dropping.mint(testAddr, random);
        assertEq(erc721Dropping.balanceOf(testAddr), random);
    }
}
