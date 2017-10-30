#!/bin/sh

docker \
    container \
    create \
    --name uniquespace \
    --interactive \
    --tty \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    endlessplanet/uniquespace:$(git rev-parse --verify HEAD)