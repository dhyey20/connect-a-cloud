#!/bin/bash

if [ -z ${PEER_MSPID} ]; then
	echo "Please set the PEER_MSPID"
	exit 1
else
	echo "Peer MSPID is ${PEER_MSPID}"
fi

if [ -z ${ORDERER_MSPID} ]; then
	echo "Please set the ORDERER_MSPID"
	exit 2
else
	echo "Orderer MSPID is ${ORDERER_MSPID}"
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
docker images | grep connectacloud-fabric-peer | awk '{print $3}' | xargs docker rmi -f

docker restart net_fabric-peer_1

echo "Starting marbles"
docker-compose up -d marbles

