IMAGE := mlafeldt/simianarmy
ENV := \
	-e SIMIANARMY_CLIENT_AWS_ACCOUNTKEY=$(AWS_ACCESS_KEY_ID) \
	-e SIMIANARMY_CLIENT_AWS_SECRETKEY=$(AWS_SECRET_ACCESS_KEY) \
	-e SIMIANARMY_CLIENT_AWS_REGION=$(AWS_REGION)

build:
	docker build --force-rm -t $(IMAGE) .

rebuild:
	docker build --pull --no-cache --force-rm -t $(IMAGE) .

run: build
	docker run -it --rm $(ENV) $(IMAGE)

shell: build
	docker run -it --rm $(ENV) $(IMAGE) /bin/bash
