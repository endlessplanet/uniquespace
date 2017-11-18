#!/bin/sh

docker volume ls --quiet --filter label=expiry | while read VOLUME
    do
        if [ $(date +%s) -gt $(docker volume inspect --format "{{index .Labels \"expiry\"}}" ${VOLUME}) ]
        then
            docker volume rm ${VOLUME}
        fi
    done