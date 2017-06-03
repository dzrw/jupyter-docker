SHELL=/bin/bash

OPT_P=-p 8888:8888

OPT_V1=-v ${PWD}/notebooks:/opt/notebooks 
OPT_V2=-v ${PWD}/inputs:/data/inputs
OPT_V3=-v ${PWD}/outputs:/data/outputs
OPT_V=${OPT_V1} ${OPT_V2} ${OPT_V3}

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
	@mkdir inputs outputs notebooks || true

shell:
	@docker exec -ti `docker ps -qf "name=jupyter"` /bin/bash
