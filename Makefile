VERSION=0.0.2

all: build

build:
	@./node_modules/coffee-script/bin/coffee \
		-c \
		-o lib src

clean:
	rm -rf lib
	mkdir lib

test:
	@./node_modules/mocha/bin/mocha \
		--require coffee-script/register \
		test/*.coffee

test-watch:
	@./node_modules/mocha/bin/mocha \
		--require coffee-script/register \
		-w --watch-extensions coffee\
		test/*.coffee

publish: test build
	tar -zcvf ./jsquickcheck-$(VERSION).tgz -C .. jsquickcheck/package.json jsquickcheck/lib jsquickcheck/README.md
	npm publish ./jsquickcheck-$(VERSION).tgz

.PHONY: build clean test
