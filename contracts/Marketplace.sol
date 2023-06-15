// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract MarketPlace{
     struct User{
        string name;
        bool isRegistered;
     }
     struct Item{
        uint256 id;
        string name;
        string description;
        uint256 quantity;
        uint256 price;
        address payable seller;
        address payable buyer;
        bool isSold;
     }
     mapping(address=>User)public users;
     Item[] public items;
     event ItemListed(uint256 itemId, string itemName , uint256 price);
     event ItemPurchased(uint256 itemId, string itemName, address buyer);
     
     modifier onlyRegisteredUser(){
        require(users[msg.sender].isRegistered,"only registered user are allowed");
        _;
     }
    function registeredAsUser(string memory _name) public{
        require(!users[msg.sender].isRegistered,"User already registered"
        );
        users[msg.sender]=User(_name,true);
    }
    function purchaseItem(uint256 _itemId) public payable onlyRegisteredUser {
        Item storage selectedItems = items[_itemId];
        require(!selectedItems.isSold,"item has already been purchased");
        require(msg.value>=selectedItems.price,"not enough balance");
        

    }



}


