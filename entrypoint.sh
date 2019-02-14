#!/bin/bash
set -e

if [ "$1" = 'nginx' ]; then
    echo "Setting up enftun"
fi

exec "$@"
