IMAGE := mlafeldt/simianarmy

build:
	docker build --force-rm -t $(IMAGE) .

rebuild:
	docker build --pull --no-cache --force-rm -t $(IMAGE) .

run: build
	docker run -t --rm $(IMAGE)
