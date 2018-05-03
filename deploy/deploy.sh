#!/usr/bin/bash

sh ./scripts/configure_rabbitmq.sh

docker cp $(docker ps --filter name="proxy" -q | awk '{ print $1 }'):/root/.ssh/id_rsa ./ssh_key

ansible-playbook -i ./inventory playbooks/deploy.yaml --key-file "./ssh_key"