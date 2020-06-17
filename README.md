# ENF Services

This repo contains Docker images to easily run some common, predefined
services on the Xaptum ENF. Run them directly or use them as
inspiration for your own.

The Xaptum ENF is a secure and scalable IPv6 overlay network for IoT
that is isolated and protected from the public Internet.  Docker
containers are an easy way deploy backend services on your ENF.

## Services

Images for each container are published to the [Xaptum Docker
Hub](https://hub.docker.com/u/xaptum).

The source for each is contained in a subdirectory in this repo.

## Usage

We recommend using cloud or physical servers running Linux to run
Docker containers on your ENF network.  For testing and development, a
desktop may be more convenient.

This section walks through the three main steps for running Docker
images on the ENF.

### Configure Docker for IPv6

Docker images for the ENF require IPv6 support, which is not enabled
by default in most Docker installations.  To enable it, add the
following options to the Docker daemon configuration file
[daemon.json](https://docs.docker.com/engine/reference/commandline/dockerd/#daemon-configuration-file).

- `"ipv6" : true`
- `"fixed-cidr-v6" : "fd00:d0c::/64"`

and restart the Docker daemon.

On Linux, `daemon.json` is located at `/etc/docker/daemon.json`.  
On Mac OS, change it via the Docker `Preferences->Daemon->Advanced` menu.

The `fixed-cidr-v6` option is required due to a
[bug](https://github.com/moby/moby/issues/36954) in Docker. The
`fd00:d0c::/64` prefix is arbitary. Replace it as desired.

### Generate ENF Access Keys

Each Docker container is one endpoint (IPv6) on your ENF and requires
its own credentials to connect to the ENF.

Create these credentials using the `enfcli`:

    enfcli connect --host <domain>.xaptum.io --user <email_address>

    enfcli> iam create-endpoint-key --key-out-file=enf0.key.pem --public-key-out-file=enf0.pub.pem
    enfcli> iam create-endpoint-with-address --address=<container_ipv6> --public-key-in-file=enf0.pub.pem
    enfcli> iam create-endpoint-cert --cert-out-file=enf0.crt.pem --identity=<container_ipv6> --key-in-file=enf0.key.pem

Pick a memorable IPv6 address for the
container. For example, `2607:8f80::deb:1` would be a good choice for a
Debian APT repo container.

Move the resulting credentials to a directory on the Docker host:

    mv enf0.key.pem /etc/enftun/my_container/
    mv enf0.crt.pem /etc/enftun/my_container/

### Run the Docker Image

Run the Docker image using this command.

    docker run --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun \
               --sysctl net.ipv6.conf.all.disable_ipv6=0              \
               --sysctl net.ipv6.conf.default.disable_ipv6=0          \
               --volume <path_to_credentials>:/data/enf0:ro           \
               --name <name> <image>

The following table explains these options.


| Option                                        | Description                                         |
|-----------------------------------------------|-----------------------------------------------------|
| --cap-add=NET_ADMIN                           | Manage ENF tunnel network interface                 |
| --device /dev/net/tun:/dev/net/tun            | Create a ENF tunnel network interface               |
| --sysctl net.ipv6.conf.all.disable_ipv6=0     | Enable IPv6 on network interfaces in the container  |
| --sysctl net.ipv6.conf.default.disable_ipv6=0 | Enable IPv6 on network interfaces in the container  |
| --volume <path_to_credentials>:/data/enf0:ro  | Mount the ENF access credentials into the container |

### Additional Details

Remember to configure the ENF firewall to allow devices to communicate
with this service.

For details on a specific service, see the README in its directory.

### Troubleshooting

#### Repeated TLS Connection Attempts

Repeated TLS connection attempts are usually caused by an incorrect
certificate or key.

```
<7>Loaded server TLS certificate /etc/enftun/enf.cacert.pem
<7>Loaded client TLS certificate /data/enf0/enf0.crt.pem
<7>Loaded client TLS private key /data/enf0/enf0.key.pem
<7>Validated client TLS cert and private key
<7>TCP: connecting to [23.147.128.112]:443
<6>TCP: Connected to [23.147.128.112]:443
<6>Completed TLS handshake
<6>Opened tun device enf0
<6>Started.
<6>Stopped.
<3>Failed to shutdown TLS connection0:(null):(null):(null)
<7>Loaded server TLS certificate /etc/enftun/enf.cacert.pem
<7>Loaded client TLS certificate /data/enf0/enf0.crt.pem
<7>Loaded client TLS private key /data/enf0/enf0.key.pem
<7>Validated client TLS cert and private key
<7>TCP: connecting to [23.147.128.112]:443
<6>TCP: Connected to [23.147.128.112]:443
<6>Completed TLS handshake
<6>Opened tun device enf0
<6>Started.
<6>Stopped.
```

Run
```
openssl x509 -in=enf0.crt.pem -noout -text
```
to verify that the `CN=` fields contain the intended IPv6 address.

```
Certificate:
<snip>
    Signature Algorithm: ecdsa-with-SHA256
        Issuer: CN=2607:8f80::deb:1
        Validity
            Not Before: Apr 23 21:21:02 2020 GMT
            Not After : Apr 23 21:21:02 2021 GMT
        Subject: CN=2607:8f80::deb:1
<snip>
```

If the IPv6 address is incorrect, recreate the certicate using the
`enfcli`.

## License

Copyright 2019–2020 Xaptum, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this work except in compliance with the License. You may obtain a copy of
the License from the LICENSE.txt file or at

[http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0)

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.
