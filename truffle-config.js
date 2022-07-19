
var HDWalletProvider = require("truffle-hdwallet-provider");
// const result = require('dotenv').config();
// if(result.error) {
//   throw result.error;
// }
var mnemonic='clown horse fit reform card avocado knife list erupt vanish pulse organ'
module.exports = {
  networks: {
    // development: {
    //   host: "127.0.0.1",
    //   port: 9545,
    //   network_id: "*"
    // },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic,"https://ropsten.infura.io/v3/068f5c1cc0a44aeaa4b42884647c8017",0)
      },
      network_id: 3
    }
  },
  compilers: {
    solc: {
      version: "0.5.0",
        settings: {
          optimizer: {
            enabled: true,
            runs: 200
        }
      }
    }
  }
}
