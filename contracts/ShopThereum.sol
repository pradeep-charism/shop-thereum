pragma solidity ^0.5.0;

contract ShopThereum {

    address payable private _shopAdminWallet = 0xfc9A0930297Fb5c497CE8C5E8b8a06b72dd70834;
    address payable private _safeWallet = 0xEeCe46429eC8e26cc6FC514d5D2a69A152E8485E;
    address payable private _buyerWallet;
    address[16] public products;

    mapping (address => uint256) public _balances;

    constructor (address payable wallet) public {
        require(wallet != address(0), "wallet is the zero address");
        _buyerWallet = wallet;
    }
    
    event BuyEvent(
        address indexed _from,
        uint indexed _id
    );

    event SellEvent(
        address indexed _from,
        uint indexed _id
    );

    function buy(uint productId) public payable returns (uint) {
        require(productId >= 0 && productId <= 15);
        products[productId] = msg.sender;
//        _shopAdminWallet.transfer(msg.value);
        _safeWallet.transfer(msg.value);
        emit BuyEvent(msg.sender, productId);
        return productId;
    }

    function sell(uint productId) public payable returns (uint) {
        require(productId >= 0 && productId <= 15);
        delete products[productId];
        _shopAdminWallet.transfer(msg.value);
//        _buyerWallet.transfer(msg.value);
//        _safeWallet.transfer(msg.value);
//        _balances[_buyerWallet]=msg.value;
        emit BuyEvent(msg.sender, productId);
        return productId;
    }

    function getProducts() public view returns (address[16]memory) {
        return products;
    }

    function() external payable{
        _safeWallet.transfer(msg.value);
    }
}

