SHELL=/bin/bash

OPT_P=-p 8888:8888

OPT_V1=-v ${PWD}/notebooks:/opt/notebooks 
OPT_V=${OPT_V1}

.PHONY: listen install clean

listen: install clean
	@docker run --name=jupyter --init -d ${OPT_P} ${OPT_V} jupyter:latest
	@sleep 1
	@docker logs -f `docker ps -qf "name=jupyter"`

install:
	@./build.sh

clean:
	@docker stop `docker ps -qf "name=jupyter"` || true
	@docker rm `docker ps -aqf "name=jupyter"` || true
	@mkdir -p notebooks/example/inputs notebooks/example/output || true

shell:
	@docker exec -ti `docker ps -qf "name=jupyter"` /bin/bash
