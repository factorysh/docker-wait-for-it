include Makefile.lint
include Makefile.build_args

GOSS_VERSION := 0.3.13

all: pull build

pull:
	docker pull bearstech/debian:buster

build:
	 docker build \
		$(DOCKER_BUILD_ARGS) \
		-t bearstech/wait-for-it \
		.

push:
	docker push bearstech/wait-for-it

remove_image:
	docker rmi bearstech/wait-for-it

tests/bin/goss:
	mkdir -p tests/bin
	curl -o tests/bin/goss -L https://github.com/aelsabbahy/goss/releases/download/v$(GOSS_VERSION)/goss-linux-amd64
	chmod +x tests/bin/goss

test: tests/bin/goss
	docker run --rm -t \
		-v `pwd`/tests/bin/goss:/usr/local/bin/goss \
		-v `pwd`/tests:/goss \
		-w /goss \
		bearstech/wait-for-it \
		goss -g wait-for-it.yml validate --max-concurrent 4 --format documentation

down:

tests: test

