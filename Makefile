IMAGE := mlafeldt/simianarmy

CHAOS_ASG_ENABLED := true
CHAOS_LEASHED     := true

ENV := -e CONFD_OPTS="$(CONFD_OPTS)" \
	-e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$(AWS_ACCESS_KEY_ID) \
	-e SIMIANARMY_CLIENT_AWS_SECRETKEY=$(AWS_SECRET_ACCESS_KEY) \
	-e SIMIANARMY_CLIENT_AWS_REGION=$(AWS_REGION) \
	-e SIMIANARMY_CLIENT_LOCALDB_ENABLED=true \
	-e SIMIANARMY_CALENDAR_ISMONKEYTIME=true \
	-e SIMIANARMY_CHAOS_ASG_ENABLED=$(CHAOS_ASG_ENABLED) \
	-e SIMIANARMY_CHAOS_LEASHED=$(CHAOS_LEASHED) \
	-e SIMIANARMY_CHAOS_TERMINATEONDEMAND_ENABLED=true

build:
	docker build --force-rm -t $(IMAGE) .

rebuild:
	docker build --pull --no-cache --force-rm -t $(IMAGE) .

run: build
	docker run -it --rm -p 8080:8080 $(ENV) $(IMAGE)

# For debugging.
shell: build
	docker run -it --rm -p 8080:8080 $(ENV) $(IMAGE) /bin/bash

# Mount checkout of Simian Army for local development. Set SIMIANARMY_CHECKOUT
# to the directory where the Git repo is checked out. Inside the container, run
# /entrypoint.sh to start the server.
dev: build
	docker run -it --rm -p 8080:8080 \
		-v "$(SIMIANARMY_CHECKOUT)/src:/simianarmy/src" \
		$(ENV) $(IMAGE) /bin/bash
