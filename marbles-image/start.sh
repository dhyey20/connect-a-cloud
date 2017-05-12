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
	exit 3
else
	echo "CA Host is ${CA_URL}"
fi

if [ -z ${CA_USER} ]; then
	echo "Please set the CA_USER"
	exit 4
else
	echo "CA User is ${CA_USER}"
fi

if [ -z ${CA_PASSWORD} ]; then
	echo "Please set the CA_PASSWORD"
	exit 5
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

sed -i "s/ORDERER_URL/${ORDERER_URL}/g" /marbles/config/blockchain_creds1.json
sed -i "s/ORDERER_MSPID/${ORDERER_MSPID}/g" /marbles/config/blockchain_creds1.json
sed -i "s/CA_URL/${CA_URL}/g" /marbles/config/blockchain_creds1.json
sed -i "s/CA_USER/${CA_USER}/g" /marbles/config/blockchain_creds1.json
sed -i "s/CA_PASSWORD/${CA_PASSWORD}/g" /marbles/config/blockchain_creds1.json
sed -i "s/PEER_MSPID/${PEER_MSPID}/g" /marbles/config/blockchain_creds1.json
sed -i "s/CHANNEL_NAME/${CHANNEL_NAME}/g" /marbles/config/blockchain_creds1.json
sed -i "s/CHAINCODE_ID/${CHAINCODE_ID}/g" /marbles/config/blockchain_creds1.json
sed -i "s/CHAINCODE_VERSION/${CHAINCODE_VERSION}/g" /marbles/config/blockchain_creds1.json

sed -i "s/COMPANY/${COMPANY}/g" /marbles/config//marbles1.json
sed -i "s/USER1/${USER1}/g" /marbles/config//marbles1.json
sed -i "s/USER2/${USER2}/g" /marbles/config//marbles1.json
sed -i "s/USER3/${USER3}/g" /marbles/config//marbles1.json

cp /certs/cacert.pem /marbles/.

node scripts/install_chaincode.js 

gulp marbles1

