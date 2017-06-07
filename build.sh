#!/bin/bash
set -euo pipefail

# Create a temporary working context for either MacOS or Linux.
rootfs=$(mktemp -2 2>/dev/null || mktemp -d -t 'jupyter')

# Run cleanup code at exit.
function on_exit() {
	echo "Would remove $rootfs"	
}

trap on_exit EXIT

function mk_entrypoint() {
	cat << EOF > $rootfs/docker-entrypoint.sh
#!/bin/bash
set -euo pipefail

/opt/conda/bin/jupyter notebook --notebook-dir=/opt/notebooks --ip='*' --port=8888 --no-browser
EOF

	chmod +x $rootfs/docker-entrypoint.sh
}

function mk_Dockerfile() {
	set +u
	cat << EOF > $rootfs/Dockerfile
FROM continuumio/anaconda3

# Add Tini
ENV TINI_VERSION v0.14.0
ADD https://github.com/krallin/tini/releases/download/\${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN apt-get update \
 && apt-get install -y graphviz \
 && mkdir /opt/notebooks \
 && /opt/conda/bin/conda install jupyter -y --quiet \
 && pip install graphviz \
 && echo Done

COPY . /

EXPOSE 8888

ENTRYPOINT ["/tini", "-s", "-vv", "--", "/docker-entrypoint.sh"]
EOF
	set -u
}

function build_image() {
	docker build -t jupyter $rootfs
}

mk_entrypoint
mk_Dockerfile
build_image

