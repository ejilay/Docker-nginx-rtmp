#!/bin/bash
set -e

DOCKER_RUN_IMAGE=nginx-rtmp
DOCKER_BUILD_IMAGE=nginx-build

rm -f nginx.tar.gz

cd build

docker build -t ${DOCKER_BUILD_IMAGE} .

cd ..

DID=`docker create ${DOCKER_BUILD_IMAGE}`

docker cp ${DID}:/tmp/nginx.tar.gz ./

docker rm ${DID}
docker rmi ${DOCKER_BUILD_IMAGE}

docker build -t ${DOCKER_RUN_IMAGE} .

docker images
docker run --rm -d --name ${DOCKER_RUN_IMAGE} -p 1935:1935 -p 8080:8080 -v `pwd`/hls:/var/www/streams -t ${DOCKER_RUN_IMAGE}
docker ps -a

