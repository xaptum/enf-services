VERSION := 1.1.0
ORG := xaptum
NAME := enftun
IMG := $(ORG)/$(NAME)

.DEFAULT_GOAL := build
.PHONY: build push shell

build: Dockerfile
	docker build -t $(IMG) .
	docker tag $(IMG):latest $(IMG):$(VERSION)

push: build
	docker push $(IMG):latest
	docker push $(IMG):$(VERSION)

keys: build
	docker run --volume `pwd`/enf0:/data/enf0 -it --entrypoint /usr/bin/enftun-keygen $(IMG):$(VERSION) -c /etc/enftun/enf0.conf -u $(user) -a $(address)

shell: build
	docker run --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.default.disable_ipv6=0 --volume `pwd`/enf0:/data/enf0:ro -it $(IMG):$(VERSION) bash
