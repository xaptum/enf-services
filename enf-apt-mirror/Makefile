# Makefile
ORG := xaptum
NAME := enf-apt-mirror
IMG := $(NAME)

.PHONY: push run

build: Dockerfile
	docker build -t $(IMG) .

push:
	@echo "docker push $(IMG)"

run:
	docker run --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.default.disable_ipv6=0 -d --volume ~/git/enf-apt-mirror/enf0:/data/enf0:ro --name $(NAME) $(IMG)

stop:
	docker stop $(NAME)
	docker rm $(NAME)

shell:
	docker exec -it $(NAME) /bin/bash
