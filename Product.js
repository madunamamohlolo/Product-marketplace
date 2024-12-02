async function buyProduct(productId, price) {
    await marketplace.buyProduct(productId, {
        value: ethers.utils.parseEther(price),
    });
    alert("Purchase successful!");
}