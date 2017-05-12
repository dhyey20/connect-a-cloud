# connect-a-cloud

## Build the peer image
```bash
cd peer-image
./build.sh
```

## Build the marbles image
```bash
cd marbles-image
./build.sh
```
## Start the peer
```bash
cd start-up
PEER_MSPID= CA_URL= CA_USER= CA_PASSWORD= ORDERER_URL= CHANNEL_NAME= ./start-peer.sh
```

## Start marbles app
```bash
cd start-up
PEER_MSPID= ORDERER_MSPID= CA_URL= CA_USER= CA_PASSWORD= ORDERER_URL= CHANNEL_NAME= CHAINCODE_ID= CHAINCODE_VERSION= COMPANY= USER1= USER2= USER3= ./start-marbles.sh
```

### NOTE:
- delete all the chaincode images from previous run for the new tls certs to be used