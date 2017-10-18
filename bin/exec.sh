#!/bin/sh

docker \
    container \
    run \
    --interactive \
    --tty \
    --rm \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    endlessplanet/uniquespace:$(git rev-parse --verify HEAD)