#!/bin/bash
set -e

if [ "$1" = 'nginx' ]; then
    echo "Setting up enftun"
    /usr/bin/enftun-setup up /etc/enftun/enf0.conf
    /usr/bin/enftun -c /etc/enftun/enf0.conf &
fi

exec "$@"
