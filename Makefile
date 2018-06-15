DOCKER_LOCAL_IP ?= $(shell (ifconfig en0 | grep -w inet | awk '{ print $$2; }'))
HOSTNAME ?= $(shell hostname)
MARATHON_CURL = curl -X POST -H "Content-type: application/json" -d @-
app ?= echo-headers

export DOCKER_LOCAL_IP
export HOSTNAME

.PHONY: run
deploy:
	eval echo $$(printf '%q' $$(cat apps/$(app).json) | sed 's/\\\$$/$$/g' | sed 's/\$$\$$/\\$$/g' | sed 's/-D/ -D/g') | $(MARATHON_CURL) "http://$(HOSTNAME):8080/v2/apps"

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
