#!/bin/sh

sh $(dirname ${0})/build.sh &&
    docker \
        container \
        run \
        --interactive \
        --tty \
        --rm \
        --mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock,readonly=true \
        --env COMMIT_ID=$(git rev-parse HEAD) \
        --env EXPIRY="now + 1 week" \
        endlessplanet/uniquespace:$(git rev-parse HEAD)