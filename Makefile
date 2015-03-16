VERSION=0.0.0

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

publish:
	tar cvfz jsquickcheck-$(VERSION).tgz package.json lib

.PHONY: build clean test
