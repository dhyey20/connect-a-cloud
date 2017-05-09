# connect-a-cloud

## Build the peer image
```bash
cd peer-image
./build.sh
```

## Start the peer
```bash
cd start-up
PEERMSPID= CA_URL= CA_USER= CA_PASSWORD= ORDERER_URL= CHANNEL_NAME= ./start.sh
```

## Join the channel 
```bash
docker exec net_fabric-peer_1 joinChannel.sh
```

## Run Marbles
- Follow the instructions [here](docs/marbles.md)

### NOTE:
- delete all the chaincode images from previous run for the new tls certs to be used