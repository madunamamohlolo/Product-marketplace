// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Product {
        uint256 id;
        string name;
        string description;
        uint256 price;
        string imageURL;
        address seller;
        address buyer;
    }

    uint256 public productCount;
    mapping(uint256 => Product) public products;
    mapping(address => uint256[]) public purchaseHistory;
    mapping(address => uint256[]) public salesHistory;

    event ProductListed(
        uint256 id,
        string name,
        uint256 price,
        string imageURL,
        address seller
    );
    event ProductBought(uint256 id, address buyer, uint256 price);

    constructor() {
        // Add predefined products during contract deployment
        listProduct(
            "E-book",
            "A comprehensive guide to blockchain basics.",
            0.02 ether,
            "https://example.com/ebook-cover.jpg"
        );
        listProduct(
            "Software License",
            "Lifetime license for productivity software.",
            0.1 ether,
            "https://example.com/software-license.jpg"
        );
        listProduct(
            "Digital Artwork",
            "A unique piece of digital art.",
            0.5 ether,
            "https://example.com/digital-artwork.jpg"
        );
    }

    // Function to list a product
    function listProduct(
        string memory _name,
        string memory _description,
        uint256 _price,
        string memory _imageURL
    ) public {
        require(_price > 0, "Price must be greater than zero");

        productCount++;
        products[productCount] = Product(
            productCount,
            _name,
            _description,
            _price,
            _imageURL,
            msg.sender,
            address(0)
        );

        salesHistory[msg.sender].push(productCount);

        emit ProductListed(productCount, _name, _price, _imageURL, msg.sender);
    }

    // Function to buy a product
    function buyProduct(uint256 _id) public payable {
        Product storage product = products[_id];
        require(_id > 0 && _id <= productCount, "Invalid product ID");
        require(msg.value == product.price, "Incorrect price");
        require(product.seller != msg.sender, "Seller cannot buy their own product");
        require(product.buyer == address(0), "Product already sold");

        product.buyer = msg.sender;
        payable(product.seller).transfer(msg.value);
        purchaseHistory[msg.sender].push(_id);

        emit ProductBought(_id, msg.sender, msg.value);
    }

    // View purchases
    function viewPurchases() public view returns (uint256[] memory) {
        return purchaseHistory[msg.sender];
    }

    // View sales
    function viewSales() public view returns (uint256[] memory) {
        return salesHistory[msg.sender];
    }
}