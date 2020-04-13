VERSION := 1.0.2
ORG := xaptum
NAMES   := $(ORG)/enf-demo-server $(ORG)/enf-demo-server-noenf

.DEFAULT_GOAL := build

build: $(NAMES)

push: $(NAMES:$(ORG)/%=push-%)

save: $(NAMES:$(ORG)/%=save-%)

stop: $(NAMES:$(ORG)/%=stop-%)

$(ORG)/%: %.dockerfile
	docker build --rm --force-rm -t $@ -f $< .
	docker tag $@:latest $@:$(VERSION)

run-%: $(ORG)/%
	docker run -P --cap-add=NET_ADMIN --device /dev/net/tun:/dev/net/tun --sysctl net.ipv6.conf.all.disable_ipv6=0 --sysctl net.ipv6.conf.default.disable_ipv6=0 -d --volume `pwd`/enf0:/data/enf0:ro --name $(<:$(ORG)/%=%) $<:$(VERSION)

stop-%:
	docker stop $(@:stop-%=%) || true
	docker rm $(@:stop-%=%) || true

shell-%:
	docker exec -it $(@:shell-%=%) /bin/bash

save-%: $(ORG)/%
	docker save -o $(<:$(ORG)/%=%)_$(VERSION).tar $<:$(VERSION)

push-%: $(ORG)/%
	docker push $<:latest
	docker push $<:$(VERSION)

clean:
	rm -f *_$(VERSION).tar
