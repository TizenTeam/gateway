#!/bin/make -f

default: run

node_modules:
	yarn

run: node_modules
	npm start

distclean:
	rm -rf ${HOME}/.mozilla-iot

eslint: .eslintrc.js
	eslint --no-color --fix .
	eslint --no-color .

.eslintrc.js:
	eslint --init

