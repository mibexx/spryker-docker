#!/bin/ash

SSH_FILE="/root/.ssh/id_rsa"

if [ ! -f $SSH_FILE ]; then
    # Generate Keygen
    ssh-keygen -q -N '' -b 2048 -t rsa -f /root/.ssh/id_rsa -q
    cat /root/.ssh/id_rsa.pub
fi

echo "root:${ROOT_PASSWORD}" | chpasswd


# Generate host keys
ssh-keygen -A


# Run SSH server
exec /usr/sbin/sshd -D -e "$@"