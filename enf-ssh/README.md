# enf-ssh

This image runs an SSH jump host to allow easy SSH access into your
devices over the ENF.

If you already have an established SSH policy and jumphost within your
organization, treat this image as an example. You can directly
integrate [`enftun`](https://github.com/xaptum/enftun) into your
existing bastion in the same fashion.

If not, this image is an quick way to get started.

# Usage

This image creates a container running an OpenSSH server and the
`enftun` client.

## Prerequisites

- [Configure](https://github.com/xaptum/enf-services) your local Docker
system to support IPv6.
- Pull the image from Docker Hub by running `make pull`.

## Setup

The first steps are to configure the ENF and SSH credentials.

1) The docker image expects the ENF certificate and private key to be
in the `enf0/` directory.  Use the `enftun-keygen` utility provided in
the image to provision these credentials by running


   ```
   make provision USER=<demo@example.com> ADDRESS=<2607:8f80:8120:1::1234>
   ```

   Replace the "USER" argument with your ENF account username and the
   "ADDRESS" argument with the address you would like to use for the
   jumphost.

   The tool will prompt you to enter your ENF account password and
   confirm your selections.

1) The SSH server is configured to allow access using your local
username (the output of `whoami`) and any public keys in the `keys/`
directory.  Copy your SSH public key into this directory using a command similar to

   ```
   cp ~/.ssh/id_rsa.pub keys/
   ```

1) Use the `enfcli` to configure the ENF firewall to allow SSH traffic from this jumphost
to other endpoints on your ENF network.

   ```
   > firewall add-firewall-rule --priority=200 --action=ACCEPT --protocol=TCP --direction=EGRESS --source-ip=2607:8f80:8120:1::1234 --source-port=22 --dest-ip=2607:8f80:8120:1::/64

   > firewall add-firewall-rule --priority=200 --action=ACCEPT --protocol=TCP --direction=INGRESS --source-ip=2607:8f80:8120:1::1234 --source-port=22 --dest-ip=2607:8f80:8120:1::/64

   > firewall add-firewall-rule --priority=200 --action=ACCEPT --protocol=TCP --direction=EGRESS --source-ip=2607:8f80:8120:1::/64 --dest-ip=2607:8f80:8120:1::1234 --dest-port=22

   > firewall add-firewall-rule --priority=200 --action=ACCEPT --protocol=TCP --direction=INGRESS --source-ip=2607:8f80:8120:1::/64 --dest-ip=2607:8f80:8120:1::1234 --dest-port=22
   ```

   Replace the specific IP networks and addresses with your own.

## Start the Jumphost

1) Start the container by running

   ```
   make start
   ```

   The container has local IP address 172.17.0.200 by default.  If needed, override with the `JUMPHOST_IP` argument:

   ```
   make start JUMPHOST_IP=<other ip>
   ```

## SSH into other Hosts

1) SSH into your ENF endpoints via the jumphost with the following command:

   ```
   ssh -J 172.17.0.200 user@2607:8f80:8120:1:4e9:bc25:ac07:5772
   ```

   Replace the username and IP address with that of your ENF endpoint.
