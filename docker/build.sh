#!/usr/bin/env bash

DOCKER_VENDOR="mibexx"
IMAGE_PREFIX="spryker"

echo "Build admin image"
docker build ./php -t $DOCKER_VENDOR/$IMAGE_PREFIX-php

echo "Build proxy image"
docker build ./admin -t $DOCKER_VENDOR/$IMAGE_PREFIX-admin

echo "Build jenkins image"
docker build ./jenkins -t $DOCKER_VENDOR/$IMAGE_PREFIX-jenkins
