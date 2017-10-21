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
    endlessplanet/volume-minder:a49d6c0cba53a09173af9eef4da12de94c383973 \
    bash