#!/bin/bash

docker rm -f $(docker ps -a -q)
docker rmi -f connectacloud-fabric-peer-end2end-v0

rm -rf config/msp
rm config/fabric-*

cd tls
./tls.sh
cd ..

docker-compose up -d