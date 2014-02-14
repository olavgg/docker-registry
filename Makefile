FLAVOR=local

.PHONY: registry run-registry python-2 python-3 pull run-python-2 run-python-3

all:
	@echo "make registry -- builds registry docker image"
	@echo "make -B config.yml -- forces rebuild of config.yml"
	@echo ""
	@echo "make start-registry -- starts registry"
	@echo "make stop-registry -- stops registry"
	@echo "make clean -- removes containers, images, and downloads"

registry: config.yml
	docker build -rm -t lukaspustina/$@ .

config.yml:
	cat $@.template | sed "s/@@SEC_KEY@@/`openssl rand -hex 32`/" > $@

start-registry: docker-registry-storage
	docker run --name registry -d -e FLAVOR=$(FLAVOR) -p 5000:5000 -v `pwd`/registry/docker-registry-storage:/docker-registry-storage lukaspustina/registry
	-@sleep 2

docker-registry-storage:
	mkdir $@

stop-registry:
	docker kill registry
	docker rm registry

clean: clean-registry-storage

clean-registry-storage:
	-@rm -rf docker-registry-storage

