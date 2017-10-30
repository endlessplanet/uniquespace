#!/bin/sh

cd $(mktemp -d) &&
    sed -e "s#\${PACKAGE_NAME}#${1}#" -e "s#\${ENTRYPOINT}#${2}#" -e "s#\${COMMAND}#${3}#" -e "wDockerfile" /opt/docker/lib/docker/alpine/Dockerfile &&
    docker image --quiet build .