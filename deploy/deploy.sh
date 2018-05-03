#!/usr/bin/bash

sh ./scripts/configure_rabbitmq.sh
ansible-playbook -i ./inventory playbooks/deploy.yaml