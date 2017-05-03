#!/bin/bash

if [ -z ${ORDERER_URL} ]; then
	echo "Please set the ORDERER_URL"
	exit 1
else
	echo "Orderer url is ${ORDERER_URL}"
fi

if [ -z ${CHANNEL_NAME} ]; then
	echo "Please set the CHANNEL_NAME"
	exit 2
else
	echo "Channel name is ${CHANNEL_NAME}"
fi

if [ -z ${TLS_HSBN_CERT} ]; then
	echo "Please set the TLS_HSBN_CERT"
	exit 5
else
	echo "TLS HSBN cert is at ${TLS_HSBN_CERT}"
fi

peer channel fetch -o ${ORDERER_URL} -c ${CHANNEL_NAME} --tls --cafile ${TLS_HSBN_CERT}

peer channel join -o ${ORDERER_URL} -b ${CHANNEL_NAME}.block -c ${CHANNEL_NAME} --tls --cafile ${TLS_HSBN_CERT}