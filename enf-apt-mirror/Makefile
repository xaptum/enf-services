# Makefile
VERSION := 1.0.0
ORG := xaptum
NAME := enf-apt-mirror
IMG := $(ORG)/$(NAME)

.PHONY: push run

build: Dockerfile
	docker build -t $(IMG) .
	docker tag $(IMG):latest $(IMG):$(VERSION)

push:
	docker push $(IMG):latest
	docker push $(IMG):$(VERSION)

run:
	docker run --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.default.disable_ipv6=0 -d --volume ~/git/enf-services/enf-apt-mirror/enf0:/data/enf0:ro --name $(NAME) $(IMG):$(VERSION)

stop:
	docker stop $(NAME)
	docker rm $(NAME)

shell:
	docker exec -it $(NAME) /bin/bash
