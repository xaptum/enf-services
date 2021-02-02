#!/bin/bash
set -e

if [[ -f "/data/enf0/enf0.conf" ]]; then
    CONF_FILE="/data/enf0/enf0.conf"
else
    CONF_FILE="/etc/enftun/enf0.conf.default"
fi

echo "Setting up enftun using config file '${CONF_FILE}'"
/usr/bin/enftun-setup up $CONF_FILE 
/usr/bin/enftun -c $CONF_FILE &

exec "$@"
