IMAGE := mlafeldt/simianarmy

build:
	docker build --pull --force-rm -t $(IMAGE) .

run: build
	docker run -t --rm $(IMAGE)
