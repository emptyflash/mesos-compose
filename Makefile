DOCKER_LOCAL_IP ?= $(shell (ifconfig en0 | grep -w inet | awk '{ print $$2; }'))
HOSTNAME ?= $(shell hostname)

export DOCKER_LOCAL_IP
export HOSTNAME

.PHONY: run
run:
	docker-compose up

.PHONY: start
start:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose stop

.PHONY: destroy
destroy: stop
	docker-compose rm -fv
