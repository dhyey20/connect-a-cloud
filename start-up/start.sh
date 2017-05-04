#!/bin/bash

if [ -z ${LOCALMSPID} ]; then
	echo "Please set the LOCALMSPID"
	exit 1
else
	echo "LOCALMSPID is ${LOCALMSPID}"
fi

if [ -z ${CA_HOST} ]; then
	echo "Please set the CA_HOST"
	exit 1
else
	echo "CA Host is ${CA_HOST}"
fi

if [ -z ${CA_PORT} ]; then
	echo "Please set the CA_PORT"
	exit 2
else
	echo "CA Port is ${CA_PORT}"
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

ARCH=`uname -m | sed 's|i686|x86_64|'`

docker pull hyperledger/fabric-ccenv:${ARCH}-1.0.0-alpha
docker rm -f $(docker ps -a -q)
docker rmi -f connectacloud-fabric-peer-end2end-v0

rm -rf config/msp
rm config/fabric-*

cd tls
./tls.sh
cd ..

ARCH=${ARCH} docker-compose up -d