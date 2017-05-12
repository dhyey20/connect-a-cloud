#!/bin/bash

export TLS_HSBN_CERT=/certs/3.secure.cert

if [ -z ${PEER_MSPID} ]; then
	echo "Please set the PEER_MSPID"
	exit 1
else
	echo "Peer MSPID is ${PEER_MSPID}"
fi

if [ -z ${CA_URL} ]; then
	echo "Please set the CA_URL"
	exit 1
else
	echo "CA URL is ${CA_URL}"
fi

if [ -z ${CA_USER} ]; then
	echo "Please set the CA_USER"
	exit 3
else
	echo "CA User is ${CA_USER}"
fi

if [ -z ${CA_PASSWORD} ]; then
	echo "Please set the CA_PASSWORD"
	exit 4
else
	echo "CA Password is ***** :P"
fi

if [ -z ${TLS_HSBN_CERT} ]; then
	echo "Please set the TLS_HSBN_CERT"
	exit 5
else
	echo "TLS HSBN cert is at ${TLS_HSBN_CERT}"
fi

if [ -z ${ORDERER_URL} ]; then
	echo "Please set the ORDERER_URL"
	exit 6
else
	echo "Orderer url is ${ORDERER_URL}"
fi

if [ -z ${CHANNEL_NAME} ]; then
	echo "Please set the CHANNEL_NAME"
	exit 7
else
	echo "Channel name is ${CHANNEL_NAME}"
fi

if [ -z ${CHAINCODE_ID} ]; then
	echo "Please set the CHAINCODE_ID"
	exit 8
else
	echo "Chaincode id is ${CHAINCODE_ID}"
fi

if [ -z ${CHAINCODE_VERSION} ]; then
	echo "Please set the CHAINCODE_VERSION"
	exit 9
else
	echo "Chaincode version is ${CHAINCODE_VERSION}"
fi

if [ -z ${COMPANY} ]; then
	echo "Please set the COMPANY"
	exit 9
else
	echo "Company name is ${COMPANY}"
fi

if [ -z ${USER1} ]; then
	echo "Please set the USER1"
	exit 9
else
	echo "User1 is ${USER1}"
fi

if [ -z ${USER2} ]; then
	echo "Please set the USER2"
	exit 9
else
	echo "User2 is ${USER2}"
fi

if [ -z ${USER3} ]; then
	echo "Please set the USER3"
	exit 9
else
	echo "User3 is ${USER3}"
fi

ARCH=`uname -m | sed 's|i686|x86_64|'`

docker pull hyperledger/fabric-ccenv:${ARCH}-1.0.0-alpha
docker-compose down
docker rmi -f connectacloud-fabric-peer-end2end-v0
docker images | grep connectacloud-fabric-peer | awk '{print $3}' | xargs docker rmi -f
rm -rf config/msp
rm config/fabric-*

cd tls
./tls.sh
cd ..

echo "Starting the peer"
docker-compose up -d fabric-peer

sleep 10

echo "Joining peer to channel: ${CHANNEL}"
docker exec net_fabric-peer_1 joinChannel.sh

sleep 10

echo "Starting marbles"
docker-compose up -d marbles

