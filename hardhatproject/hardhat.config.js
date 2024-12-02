require("@nomiclabs/hardhat-ethers");
require("dotenv").config();

module.exports = {
  solidity: "0.8.0",
  networks: {
    sepolia: {
      url: "https://sepolia.infura.io/v3/86c5375269314983bb193e118f39b05d",
      accounts: [`0x$0x3874B671F4251B293cB9E7DC72945114e8c5716A`], // Load private key securely from .env
    },
  },
};
