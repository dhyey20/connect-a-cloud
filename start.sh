#!/bin/sh                                                                       
# requirements: python

export CHANNEL=<channel name>

export COMPANY=<your company>
export USER1=<user 1>
export USER2=<user 2>
export USER3=<user 3>

SC_FILE="./service-creds.json" # service credentials from Bluemix               

getValue () {
    python -c "import sys, json; print json.load(sys.stdin)${1}" < ${SC_FILE}
}

getURL () {
    # need to remove protocol part from URL                                     
    getValue $1 | sed 's|^.*://||g'
}

export ORDERER_URL="$( getURL   "['orderers'][0]['api_url']" )"
export CA_URL="$(      getURL   "['cas'][0]['api_url']" )"
export MSPID="$(       getValue "['cas'][0]['msp_id']" )"
# the following assumes that user 'admin' is always the first user in the 'users_clients' list                                                                 
export PASSWORD="$(    getValue "['cas'][0]['users_clients'][0]['enrollSecret']" )"     


cd peer-image/
./build.sh
cd ../marbles-image/
./build.sh
cd ../start-up
# Start the peer container                                                      

echo "PEER_MSPID=${MSPID} CA_URL=${CA_URL} CA_USER=admin CA_PASSWORD=${PASSWORD} ORDERER_URL=${ORDERER_URL} CHANNEL_NAME=mychannel ./start-peer.sh"
# Start the marbles container                                                   
echo "PEER_MSPID=${MSPID} ORDERER_MSPID=OrdererMSP CA_URL=${CA_URL} CA_USER=admin CA_PASSWORD=${PASSWORD} ORDERER_URL=${ORDERER_URL} CHANNEL_NAME=mychannel CHAINCODE_ID=marbles CHAINCODE_VERSION=v1 COMPANY=${COMPANY} USER1=${USER1} USER2=${USER2} USER3=${USER3} ./start-marbles.sh"

PEER_MSPID=${MSPID} CA_URL=${CA_URL} CA_USER=admin CA_PASSWORD=${PASSWORD} ORDERER_URL=${ORDERER_URL} CHANNEL_NAME=${CHANNEL} ./start-peer.sh
# Start the marbles container                                                   
PEER_MSPID=${MSPID} ORDERER_MSPID=OrdererMSP CA_URL=${CA_URL} CA_USER=admin CA_PASSWORD=${PASSWORD} ORDERER_URL=${ORDERER_URL} CHANNEL_NAME=${CHANNEL} CHAINCODE_ID=marbles CHAINCODE_VERSION=v1 COMPANY=${COMPANY} USER1=${USER1} USER2=${USER2} USER3=${USER3} ./start-marbles.sh
