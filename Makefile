#!/bin/make -f

#SHELL:= /bin/bash --init-file .env.tmp


default: run
	@echo "$@: $^"

PATH := .:${PATH}:.
NODE_PATH := .
export NODE_PATH
#SHELL := NODE_PATH=. ${SHELL}


node_modules: package.json
	yarn

run: node_modules
	npm start

nvm/run: node_modules
	echo TODO
	bash -c ". ${HOME}/.bashrc && nvm use v8 && npm start"

distclean:
	rm -rf ${HOME}/.mozilla-iot

eslint: .eslintrc.js
	eslint --no-color --fix . ||:
	eslint --no-color .

.eslintrc.js:
	eslint --init

help:
	@echo 'nvm install v8 && nvm use v8'

version:
	node --version
	npm --version

env: ~/.nvm/nvm.sh
	. $< &&	nvm install v8 && nvm use v8


.env.tmp: Makefile
	echo 'set -x' > $@
	echo '. ~/.nvm/nvm.sh && nvm install v8 && nvm use v8 && nvm ls' >> $@


run/docker: docker-compose.yml Dockerfile
	docker-compose up

clean:
	rm -rf node_modules

addons: ${HOME}/.mozilla-iot/addons/thing-url-adapter ${HOME}/.mozilla-iot/addons/virtual-things-adapter
	ls $<

${HOME}/.mozilla-iot/addons/%: ${HOME}/.mozilla-iot
	rm -rf $@
	mkdir -p ${@D}
	git clone https://github.com/mozilla-iot/${@F} ${@}
	cd $@ && npm install


${HOME}/.mozilla-iot.mine: ${HOME}/.mozilla-iot
	ls $@ || { rm -rf $@ ; cp -rfa $^ $@; }

${HOME}/.mozilla-iot:
	ls $@ || make run

devel: ${HOME}/.mozilla-iot.mine eslint
	rm -rf ${HOME}/.mozilla-iot
	cp -rfa $< ${HOME}/.mozilla-iot
	${MAKE} run

test:
	echo $${PATH}
	echo $${NODE_PATH}
	${SHELL} -c "echo $${NODE_PATH}"
