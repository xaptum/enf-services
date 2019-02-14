# enf-apt-mirror

This image runs an APT package repository mirror for Debian or Ubuntu.
It will allow Debian or Ubuntu gateways on the ENF to install updatesa
and new packages.

## Usage

Follow the instructions in the [enf-services
README](https://github.com/xaptum/enf-services) to configure the
Docker host and create credentials for this container.

The suggested ENF IPv6 address for the container is
`fd00:0:0:0::deb:1`, replacing `fd00:0:0:0` with your actual ENF
network prefix.

### Specifying the Mirrored Repository

By default the image will mirror the main Debian stretch apt repo.  To
change override this, use the `PROXY_URL` environment variable.

``` bash
docker run -e "PROXY_URL=<desired_url>"
```

### Run the Container

Manually run the container using the following command.

```bash
docker run                                            \
   --cap-add=NET_ADMIN                                \
   --device /dev/net/tun:/dev/net/tun                 \
   --sysctl net.ipv6.conf.all.disable_ipv6=0          \
   --sysctl net.ipv6.conf.default.disable_ipv6=0      \
   --detach=true                                      \
   --restart=always                                   \
   --env "PROXY_URL=http://deb.debian.org"            \
   --volume /etc/enftun/enf-apt-debian/:/data/enf0:ro \
   --name=enf-apt-debian                              \
   xaptum/enf-apt-mirror
```

Or use the provided `docker-compose.yml` configuration.

``` bash
docker-compose up
```

### Configure the ENF Firewall

To enable devices on the ENF network to communicate with this
container, configure the following firewall rules in the `enfcli`.
Replace `fd00:0:0:0` with your network prefix.

``` bash
# Allow all devices to send requests to the APT mirror
firewall add-firewall-rule --network=fd00:0:0:0::/64 --priority=200 --protocol=TCP --source-ip=fd00:0:0:0::/64 --dest-ip=fd00:0:0:0::deb:1 --dest-port=80 --direction=EGRESS --action=ACCEPT

# Allow the APT mirror to receive those requests
firewall add-firewall-rule --network=fd00:0:0:0::/64 --priority=200 --protocol=TCP --source-ip=fd00:0:0:0::/64 --dest-ip=fd00:0:0:0::deb:1 --dest-port=80 --direction=INGRESS --action=ACCEPT

# Allow the APT mirror to send responses to all devices
firewall add-firewall-rule --network=fd00:0:0:0::/64 --priority=200 --protocol=TCP --dest-ip=fd00:0:0:0::/64 --source-ip=fd00:0:0:0::deb:1 --source-port=80 --direction=EGRESS --action=ACCEPT

# Allow all devices to receive those responses
firewall add-firewall-rule --network=fd00:0:0:0::/64 --priority=200 --protocol=TCP --dest-ip=fd00:0:0:0::/64 --source-ip=fd00:0:0:0::deb:1 --source-port=80 --direction=INGRESS --action=ACCEPT
```

### Point Devices at the Mirror

Configure APT on each host to communicate with this APT mirror.

A simple method for this is to at an entry in `/etc/hosts` mapping the repo URLs to the mirror IPv6 address.  For example, on Debian add the following entry to `/etc/hosts`

```
fd00:0:0:0::deb:1    deb.debian.org security.debian.org
```

Check `/etc/apt/sources.list` for the correct URLs to map.

## License

Copyright 2019 Xaptum, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this work except in compliance with the License. You may obtain a copy of
the License from the LICENSE.txt file or at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.
