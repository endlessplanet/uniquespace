#!/bin/sh

docker \
    container \
    run \
    --interactive \
    --tty \
    --rm \
    $(docker volume ls --quiet | head -n 100 | while read VOLUME
        do
            echo "--mount type=volume,source=${VOLUME},destination=/srv/${VOLUME},readonly=true "
        done
    ) \
    endlessplanet/volume-minder:0ef07dbf735e671dbe537fed184c703e91e13fbf \
    bash