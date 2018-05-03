#!/bin/ash

SSH_FILE="/root/.ssh/id_rsa"

if [ ! -f $SSH_FILE ]; then
    # Generate Keygen
    ssh-keygen -q -N '' -b 2048 -t rsa -f /root/.ssh/id_rsa -q
    cat /root/.ssh/id_rsa.pub
fi

if [ -f "/run/secrets/rootpassword" ]; then
    ROOT_PASSWORD=$(less /run/secrets/rootpassword)
    export ROOT_PASSWORD=$ROOT_PASSWORD
    echo "root:${ROOT_PASSWORD}" | chpasswd
fi

# Generate host keys
ssh-keygen -A

cat /root/.ssh/id_rsa.pub  >> /root/.ssh/authorized_keys

# Run SSH server
exec /usr/sbin/sshd -D -e "$@"