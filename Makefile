IMAGE := mlafeldt/simianarmy

ENV := -e CONFD_OPTS="$(CONFD_OPTS)" \
	-e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$(AWS_ACCESS_KEY_ID) \
	-e SIMIANARMY_CLIENT_AWS_SECRETKEY=$(AWS_SECRET_ACCESS_KEY) \
	-e SIMIANARMY_CLIENT_AWS_REGION=$(AWS_REGION) \
	-e SIMIANARMY_CALENDAR_ISMONKEYTIME=true

build:
	docker build --force-rm -t $(IMAGE) .

rebuild:
	docker build --pull --no-cache --force-rm -t $(IMAGE) .

run: build
	docker run -it --rm $(ENV) $(IMAGE)

# For debugging.
shell: build
	docker run -it --rm $(ENV) $(IMAGE) /bin/bash

# The Simian Army persists state in SimpleDB.
dump-sdb:
	aws sdb select --select-expression "select * from SIMIAN_ARMY" | jq

wipe-sdb:
	aws sdb delete-domain --domain-name SIMIAN_ARMY
