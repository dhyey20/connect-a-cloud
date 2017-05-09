#!/bin/bash

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

export FABRIC_CA_CLIENT_HOME=${CORE_PEER_MSPCONFIGPATH}/..

echo "Getting the certs from CA"
if [ "${CORE_PEER_TLS_ENABLED}" == "true" ]; then
	echo "fabric-ca-client enroll -u https://${CA_USER}:CA_PASSWORD@${CA_URL} --tls.enabled --tls.certfiles ${TLS_HSBN_CERT}"
	fabric-ca-client enroll -u https://${CA_USER}:${CA_PASSWORD}@${CA_URL} --tls.enabled --tls.certfiles ${TLS_HSBN_CERT}
else
	echo "fabric-ca-client enroll -u http://${CA_USER}:CA_PASSWORD@${CA_URL}"
	fabric-ca-client enroll -u http://${CA_USER}:${CA_PASSWORD}@${CA_URL}
fi

set +e
mv ${CORE_PEER_MSPCONFIGPATH}/cacerts/*.pem ${CORE_PEER_MSPCONFIGPATH}/cacerts/cacert.pem
mv ${CORE_PEER_MSPCONFIGPATH}/cacerts/.pem ${CORE_PEER_MSPCONFIGPATH}/cacerts/cacert.pem
set -e
mkdir -p ${CORE_PEER_MSPCONFIGPATH}/admincerts
cp ${CORE_PEER_MSPCONFIGPATH}/cacerts/* ${CORE_PEER_MSPCONFIGPATH}/admincerts/.
mkdir -p ${PEER_CFG_PATH}/msp/sampleconfig

# start the peer executable
peer node start --peer-defaultchain=false