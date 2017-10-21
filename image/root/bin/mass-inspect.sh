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
    endlessplanet/volume-minder:e18b759eaa0e2dae7f5a7dc8cea56491a3e795a2 \
    bash