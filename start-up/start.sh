#!/bin/bash
TLS_HSBN_CERT=/certs/3.secure.cert

if [ -z ${PEERMSPID} ]; then
	echo "Please set the PEERMSPID"
	exit 1
else
	echo "PEERMSPID is ${PEERMSPID}"
fi

if [ -z ${CA_URL} ]; then
	echo "Please set the CA_URL"
	exit 1
else
	echo "CA Host is ${CA_URL}"
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
docker-compose down -d
docker rmi -f connectacloud-fabric-peer-end2end-v0

rm -rf config/msp
rm config/fabric-*

cd tls
./tls.sh
cd ..

ARCH=${ARCH} docker-compose up -d