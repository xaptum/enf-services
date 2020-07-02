VERSION := 1.0.1
ORG := xaptum
NAME := enf-ssh
IMG := $(ORG)/$(NAME)

## Override the on the command line
## make USER=... ADDRESS=... DNS=...
USER := user@example.com
ADDRESS := fe80::1
DNS := fe80::2
JUMPHOST_IP := 172.17.0.200

.DEFAULT_GOAL := build
.PHONY: build push provision start stop

build: Dockerfile
	docker build -t $(IMG) .
	docker tag $(IMG):latest $(IMG):$(VERSION)

push: build
	docker push $(IMG):latest
	docker push $(IMG):$(VERSION)

pull:
	docker pull $(IMG):$(VERSION)

provision:
	docker run                                      \
	  --volume `pwd`/enf0:/data/enf0                \
	  --entrypoint /usr/bin/enftun-keygen           \
	  -it $(IMG):$(VERSION)                         \
	    -c /etc/enftun/enf0.conf                    \
	    -u $(USER)                                  \
	    -a $(ADDRESS)

start:
	docker run                                      \
	  --cap-add=NET_ADMIN                           \
	  --device /dev/net/tun:/dev/net/tun            \
	  --sysctl net.ipv6.conf.all.disable_ipv6=0     \
	  --sysctl net.ipv6.conf.default.disable_ipv6=0 \
	  --volume `pwd`/enf0:/data/enf0:ro             \
	  --volume `pwd`/keys:/data/keys:ro             \
	  --ip $(JUMPHOST_IP)                           \
	  --dns $(DNS)                                  \
	  --name jumphost                               \
	  -e USER=`whoami`                              \
	  --rm -d -it $(IMG):$(VERSION)

stop:
	docker kill jumphost
