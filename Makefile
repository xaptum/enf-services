# Makefile
NAME := enf-apt
IMG := $(NAME)

.PHONY: push run

build: Dockerfile
	docker build -t $(IMG) .

push:
	@echo "docker push $(IMG)"

run:
	docker run --name $(NAME) $(IMG)

stop:
	docker stop $(NAME)
	docker rm $(NAME)

shell:
	docker exec -it $(NAME) /bin/bash
