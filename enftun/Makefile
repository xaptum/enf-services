# Makefile
ORG := xaptum
NAME := enftun
IMG := $(ORG)/$(NAME)

.PHONY: push run

build: Dockerfile
	docker build -t $(IMG) .

push:
	docker push $(IMG)

shell:
	docker run --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.default.disable_ipv6=0 --volume `pwd`/enf0:/data/enf0:ro -it $(IMG) bash
