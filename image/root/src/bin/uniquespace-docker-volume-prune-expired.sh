#!/bin/sh

echo AA00110 &&
    docker volume ls --quiet --filter label=expiry | while read VOLUME
    do
        echo AA00111 &&
            [ "$(date +%s)" -gt "$(docker volume inspect --format "{{index .Labels \"expiry\"}}" ${VOLUME})" ] &&
            echo AA00112 &&
            docker volume rm ${VOLUME} &&
            echo AA00113
    done &&
    echo AA00120
