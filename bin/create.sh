#!/bin/sh

docker \
    container \
    create \
    --name uniquespace \
    --interactive \
    --tty \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --env DISPLAY \
    --env-file public.env.sh \
    --env-file private.env.sh \
    endlessplanet/uniquespace:$(git rev-parse --verify HEAD)