const purchases = await marketplace.viewPurchases();
console.log("Your Purchases:", purchases);

const sales = await marketplace.viewSales();
console.log("Your Sales:", sales);