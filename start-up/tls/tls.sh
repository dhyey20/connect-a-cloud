#!/bin/bash

# cleanup old stuff
# this includes deleting all the old certs and csrs
rm *.pem
rm *.csr
rm *.txt*

# make text files for ca to track issued certs
touch index.txt
echo '01' > serial.txt

# generate ca key and cert
openssl req -x509 -config openssl-ca.cnf -newkey rsa:4096 -sha256 -nodes -out cacert.pem -outform PEM -subj "/C=US/ST=North Carolina/L=Raleigh/O=IBM/OU=ROOT CA/CN=blockchain.com"

# if you want to inspect
# openssl x509 -in cacert.pem -text -noout
# openssl x509 -purpose -in cacert.pem -inform PEM

# generate csr's & sign using ca
# as we are using docker-compose network called blockchain.com and the docker-compose project name as net, the network created is net_blockchain.com
# thus it is used as part of common name for all the certs, eg: orderer-0a.net_blockchain.com

#peerlocal
openssl req -config openssl-server.cnf -newkey rsa:2048 -sha256 -nodes -out servercert.csr -outform PEM -keyout peerlocal-key.pem -subj "/C=US/ST=North Carolina/L=Raleigh/O=IBM/OU=PeerOrg1/CN=fabric-peer-local.net_blockchain.com"
openssl ca -batch -config openssl-ca.cnf -policy signing_policy -extensions signing_req -out peerlocal-cert.pem -infiles servercert.csr

cat 3.secure.cert >> cacert_new.pem
cat cacert.pem >> cacert_new.pem
mv cacert_new.pem cacert.pem