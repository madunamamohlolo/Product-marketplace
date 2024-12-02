const marketplace = await ethers.getContractAt("Marketplace", "YOUR_CONTRACT_ADDRESS");

// Fetch Product Details
const product1 = await marketplace.products(1);
console.log(product1);

const product2 = await marketplace.products(2);
console.log(product2);

const product3 = await marketplace.products(3);
console.log(product3);