#!/bin/bash

if [ -n $USER ]; then
    echo "Creating user $USER"
    useradd -m -s /bin/bash $USER
fi

mkdir -p /home/$USER/.ssh
cat /data/keys/* >> /home/$USER/.ssh/authorized_keys

chown -R $USER: /home/$USER/.ssh
chmod -R 700 /home/$USER/.ssh

CMD="/usr/sbin/sshd -D -e"

/usr/local/bin/enftun-entrypoint.sh $CMD
