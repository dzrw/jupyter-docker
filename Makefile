SHELL=/bin/bash

OPT_P=-p 8888:8888

OPT_V1=-v ${PWD}/notebooks:/opt/notebooks 
OPT_V=${OPT_V1}

.PHONY: listen install clean

listen: clean install
	@docker run --name=jupyter --init -d ${OPT_P} ${OPT_V} jupyter:latest
	@sleep 1
	@echo
	@echo 'Done. Run `make logs` to get the login URL, or `make clean` to halt the server.'

logs:
	@docker logs -f `docker ps -qf "name=jupyter"`

install:
	@mkdir -p notebooks/example/inputs notebooks/example/output || true
	@./build.sh

clean:
	@docker ps -qf "name=jupyter" | xargs -I XX docker stop XX
	@docker ps -aqf "name=jupyter" | xargs -I XX docker rm XX

shell:
	@docker exec -ti `docker ps -qf "name=jupyter"` /bin/bash
