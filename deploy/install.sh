#!/usr/bin/bash

sh ./scripts/configure_rabbitmq.sh

PROXY_CONTAINER=$(docker ps --filter name="spryker_admin" -q | awk '{ print $1 }')
docker cp "$PROXY_CONTAINER:/root/.ssh/id_rsa" ./ssh_key
ansible-playbook -i ./inventory playbooks/install.yaml --key-file "./ssh_key"