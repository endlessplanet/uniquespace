#!/bin/sh

docker image ls --quiet --filter label=expiry | while read IMAGE
do
    [ $(date +%s) -gt $(docker image inspect ${IMAGE} --format "{{index .Config.Labels \"expiry\"}}") ] &&
        [ -z "$(docker container ls --quiet --filter ancestor=${IMAGE})" ] &&
        docker image rm ${IMAGE}
done