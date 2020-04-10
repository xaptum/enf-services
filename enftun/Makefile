ORG := xaptum
NAME := enftun
IMG := $(ORG)/$(NAME)

.DEFAULT_GOAL := build
.PHONY: build push shell

build: Dockerfile
	docker build -t $(IMG) .

push: build
	docker push $(IMG)

shell: build
	docker run --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.default.disable_ipv6=0 --volume `pwd`/enf0:/data/enf0:ro -it $(IMG) bash
