#!/bin/bash
ARCH=`uname -m | sed 's|i686|x86_64|'`

if [[ "${ARCH}" == "x86_64" ]]; then
	docker build -f Dockerfile-x86 -t marbles:local .
elif [[ "${ARCH}" == "s390x" ]]; then
	docker build -f Dockerfile-z -t marbles:local .
else
	echo "Unsupported architecure";
	exit 1
fi