# Setting up Marbles for running with docker-compose

## With TLS

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

### Installing node modules for marbles
```bash
# make sure you are at root of marbles
npm install
npm install -g gulp
```

### Setup marbles config
  - copy the tls cacert.pem from `connect-a-cloud/start-up/tls/cacert.pem` to `marbles/cacert.pem`
  - change the `marbles/config/blockchain_creds1.json`, [here](blockchain_creds1.json) is an example. One thing to note here is the `tls_certificate` path.
  
### Done setting up -> now run marbles!!
```bash
# make sure you are at root of marbles

# install chaincode
node scripts/install-chaincode.js

# instantiate chaincode
node scripts/instantiate-chaincode.js

# now go to root of marbles
gulp marbles1

# at this point you need to go to ui / follow the instructions
```