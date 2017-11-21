#!/bin/sh

docker image ls --quiet --filter label=expiry | while read IMAGE
    do
        if [ $(date +%s) -gt $(docker image inspect --format "{{index .Config.Labels \"expiry\"}}" ${IMAGE}) ]
        then
            docker volume rm ${IMAGE}
        fi
    done