IMAGE := mlafeldt/simianarmy

# Use custom SimpleDB domain for testing.
SDB_DOMAIN := DOCKER_SIMIAN_ARMY

ENV := -e CONFD_OPTS="$(CONFD_OPTS)" \
	-e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$(AWS_ACCESS_KEY_ID) \
	-e SIMIANARMY_CLIENT_AWS_SECRETKEY=$(AWS_SECRET_ACCESS_KEY) \
	-e SIMIANARMY_CLIENT_AWS_REGION=$(AWS_REGION) \
	-e SIMIANARMY_RECORDER_SDB_DOMAIN=$(SDB_DOMAIN) \
	-e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
	-e SIMIANARMY_CHAOS_ASG_ENABLED=true

build:
	docker build --force-rm -t $(IMAGE) .

rebuild:
	docker build --pull --no-cache --force-rm -t $(IMAGE) .

run: build
	docker run -it --rm $(ENV) $(IMAGE)

# For debugging.
shell: build
	docker run -it --rm $(ENV) $(IMAGE) /bin/bash

# Mount checkout of Simian Army for local development. Set SIMIANARMY_CHECKOUT
# to the directory where the Git repo is checked out. Inside the container, run
# /entrypoint.sh to start the server.
dev: build
	docker run -it --rm \
		-v "$(SIMIANARMY_CHECKOUT)/src:/simianarmy/src" \
		$(ENV) $(IMAGE) /bin/bash

# The Simian Army persists state in SimpleDB.
dump-sdb:
	aws sdb select --select-expression "select * from $(SDB_DOMAIN)" | jq

wipe-sdb:
	aws sdb delete-domain --domain-name $(SDB_DOMAIN)
