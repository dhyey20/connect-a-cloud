# Setting up Marbles for running with docker-compose

## With TLS

### Clone the fabric-sdk-node / alpha branch
```bash
git clone https://github.com/hyperledger/fabric-sdk-node

# if you want to use the alpha branch
git checkout v1.0.0-alpha
```
### Clone marbles
```bash
git clone https://github.com/ibm-blockchain/marbles

# make sure you are on v3.0 branch(default)
git branch
```

### To clean the key value store
```bash
rm -rf ~/.hfc-key-store/*
rm -rf /tmp/hfc-*
```

### Installing node modules and configuring the sdk for use
```bash
# make sure you are at root of fabric-sdk-node
npm install
gulp ca

# Object.serialize error? 
#"grpc": "1.2.4", in fabric-sdk-node/fabric-client/package.json
```

### Installing node modules for marbles
```bash
# make sure you are at root of marbles
npm install
npm install -g gulp
```

### Copy the tls cacert.pem
  - copy the tls cacert.pem from `connect-a-cloud/start-up/tls/cacert.pem` to `fabric-sdk-node/cacert.pem`
  - Note that this will appear only if you ran the network start script. Make sure you copy the cacert.pem in the fabric-sdk-node root folder.

### Change the config file
  - This can be found in fabric-sdk-node/test/integration/e2e/config.json
  - A sample can be found [here](sample-e2e-config.json)

### Setup fabric-node-sdk e2e for marbles chaincode
  - in `fabric-sdk-node/test/fixtures/src/github.com/example_cc` delete the `example_cc.go` 
  - copy `marbles/chaincode/src/marbles/*` to  `fabric-sdk-node/test/fixtures/src/github.com/example_cc`
  - in `fabric-sdk-node/test/integration/e2e/instantiate-chaincode.js` -> change `args: ['a', '100', 'b', '200'],` to `args: ['123'],`
  - in `fabric-sdk-node/test/unit/util.js` change the ca password on line 195
	`return getSubmitter('admin', '*******', client, test, fromConfig, userOrg);`



### Setup marbles config
  - copy the tls cacert.pem from `connect-a-cloud/start-up/tls/cacert.pem` to `marbles/config/cacert.pem`
  - change the `marbles/config/blockchain_creds1.json`, [here](blockchain_creds1.json) is an example. One thing to note here is the `tls_certificate` path.
  
### Done setting up -> now run marbles!!
```bash
# make sure you are at root of node-sdk

# install chaincode
node test/integration/e2e/install-chaincode.js

# instantiate chaincode
node test/integration/e2e/instantiate-chaincode.js

# now go to root of marbles
gulp marbles1

# at this point you need to go to ui / follow the instructions
```