#!/bin/sh

docker \
    container \
    create \
    --name uniquespace \
    --interactive \
    --tty \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --env DISPLAY \
    endlessplanet/uniquespace:$(git rev-parse --verify HEAD)