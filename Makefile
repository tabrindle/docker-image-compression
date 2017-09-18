SHELL := /bin/bash
.PHONY: build test

build:
	@docker build . -t docker-image-compression

test:
	@docker run -v $$(pwd):/tmp --rm docker-image-compression test/test.png