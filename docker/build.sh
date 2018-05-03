#!/usr/bin/env bash

DOCKER_VENDOR="mibexx"
IMAGE_PREFIX="spryker"

echo "Build proxy image"
docker build ./proxy -t $DOCKER_VENDOR/$IMAGE_PREFIX-proxy

echo "Build admin image"
docker build ./admin -t $DOCKER_VENDOR/$IMAGE_PREFIX-admin

echo "Build jenkins image"
docker build ./jenkins -t $DOCKER_VENDOR/$IMAGE_PREFIX-jenkins
