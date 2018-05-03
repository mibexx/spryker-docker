#!/usr/bin/bash

sh ./scripts/configure_rabbitmq.sh

PROXY_CONTAINER=$(docker ps --filter name="proxy" -q | awk '{ print $1 }')

docker cp $PROXY_CONTAINER:/root/.ssh/id_rsa ./ssh_key

ansible-playbook -i ./inventory playbooks/deploy.yaml --key-file "./ssh_key"