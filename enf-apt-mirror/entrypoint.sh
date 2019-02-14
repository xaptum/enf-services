#!/bin/bash
set -e

function sedeasy {
    sed -i "s/$1/$(echo $2 | sed -e 's/[\/&]/\\&/g')/g" $3
}

if [ "$1" = 'nginx' ]; then
    echo "Setting up enftun"
    sedeasy "proxy_url_placeholder" "${PROXY_URL}" /etc/nginx/conf.d/cacher.conf
    /usr/bin/enftun-setup up /etc/enftun/enf0.conf
    /usr/bin/enftun -c /etc/enftun/enf0.conf &    
fi

exec "$@"
