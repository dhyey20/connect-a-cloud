# connect-a-cloud

## Build the peer image
```bash
cd peer-image
./build.sh
```

## Start the peer
```bash
cd start-up
LOCALMSPID= CA_HOST= CA_PORT= CA_USER= CA_PASSWORD= TLS_HSBN_CERT= ORDERER_URL= CHANNEL_NAME= ./start.sh
```

## Run Marbles
- Follow the instructions [here](docs/marbles.md)