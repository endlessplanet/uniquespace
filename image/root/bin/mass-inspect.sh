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
    endlessplanet/volume-minder:22821f80338285c3da2fc8278b0f9ebcf6f82de2 \
    bash