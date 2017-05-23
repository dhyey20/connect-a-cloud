# connect-a-cloud

## Run using start script
```
- Copy your HSBN Bluemix Service Credentials to service-creds.json file.

- Make changes in the start.sh file -> Add CHANNEL, COMPANY, USER1, USER2, USER3

- Run the start script (Requires python)
```

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
#URLs here should not contain the protocol part like https and grpcs
#CA_USER & CA_PASSWORD are the enrollID and enrollSecrets that you get in the credentials block from bluemix
```

## Start marbles app
```bash
cd start-up
PEER_MSPID= ORDERER_MSPID= CA_URL= CA_USER= CA_PASSWORD= ORDERER_URL= CHANNEL_NAME= CHAINCODE_ID= CHAINCODE_VERSION= COMPANY= USER1= USER2= USER3= ./start-marbles.sh
#URLs here should not contain the protocol part like https and grpcs
#CA_USER & CA_PASSWORD are the enrollID and enrollSecrets that you get in the credentials block from bluemix
```

### NOTE:
- delete all the chaincode images from previous run for the new tls certs to be used