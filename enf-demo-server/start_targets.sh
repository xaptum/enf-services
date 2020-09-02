#!/bin/bash
set -e

# Give ENFTUN a little time to connect
sleep 5

# Find address of `enf0` interface (which we'll bind to)
INTERFACE=$(awk '/2607.*enf0/{ print $1 }' /proc/net/if_inet6 | sed -r 's/.{4}/\0:/g;s/:$//g')

/usr/local/bin/xdemo_target_servers /usr/local/share/xaptum/ /var/log/xaptum/xdemo_target_servers.log $INTERFACE
