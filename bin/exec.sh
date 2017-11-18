#!/bin/sh

sh $(dirname ${0})/build.sh &&
    docker \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,readonly=true \
        endlessplanet/uniquespace:$(git rev-parse HEAD)