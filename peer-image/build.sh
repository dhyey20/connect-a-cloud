#!/bin/bash
ARCH=`uname -m | sed 's|i686|x86_64|'`
SNAPSHOT=alpha
VERSION=1.0.0
BASE_FOLDER=${PWD}

PEER_DOCKER_REPOSITORY=hyperledger/fabric-peer
PEER_VERSION=${ARCH}-${VERSION}-${SNAPSHOT}

PEER_CFG_PATH=/etc/hyperledger/fabric

docker run --rm -v ${BASE_FOLDER}/output/executable:/opt ${PEER_DOCKER_REPOSITORY}:${PEER_VERSION} cp /usr/local/bin/peer /opt
docker run --rm -v ${BASE_FOLDER}/output/peerconfig:/opt ${PEER_DOCKER_REPOSITORY}:${PEER_VERSION} cp -r ${PEER_CFG_PATH} /opt

# Getting the ca-client executable
CA_SNAPSHOT=alpha
CA_DOCKER_REPOSITORY=hyperledger/fabric-ca
CA_DOCKER_VERSION=${ARCH}-${VERSION}-${CA_SNAPSHOT}

#COP_HOME_PATH=/etc/hyperledger/fabric-ca-server
#docker run --rm -v ${BASE_FOLDER}/output/executable:/opt ${CA_DOCKER_REPOSITORY}:${CA_DOCKER_VERSION} cp /usr/local/bin/fabric-ca-server /opt
docker run --rm -v ${BASE_FOLDER}/output/executable:/opt ${CA_DOCKER_REPOSITORY}:${CA_DOCKER_VERSION} cp /usr/local/bin/fabric-ca-client /opt
#docker run --rm -v ${BASE_FOLDER}/output/config:/opt ${CA_DOCKER_REPOSITORY}:${CA_DOCKER_VERSION} cp -r ${COP_HOME_PATH} /opt

cd ${BASE_FOLDER}
if [[ "${ARCH}" == "x86_64" ]]; then
	docker build -f Dockerfile-x86 -t hyperledger/fabric-peer:local .
	docker run --rm -v ${BASE_FOLDER}:/random debian:jessie rm -rf /random/output
elif [[ "${ARCH}" == "s390x" ]]; then
	docker build -f Dockerfile-z -t hyperledger/fabric-peer:local .
	docker run --rm -v ${BASE_FOLDER}:/random s390x/debian:jessie rm -rf /random/output
else
	echo "Unsupported architecure";
	exit 1
fi

docker tag hyperledger/fabric-peer:local dhyeyibm/fabric-peer:${PEER_VERSION}