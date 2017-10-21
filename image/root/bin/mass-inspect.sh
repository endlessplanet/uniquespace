#!/bin/sh

cat /home/user/bin/inspect-files | docker \
    container \
    run \
    --interactive \
    --rm \
    $(docker volume ls --quiet | head -n 100 | while read VOLUME
        do
            echo "--mount type=volume,source=${VOLUME},destination=/srv/${VOLUME},readonly=true "
        done
    ) \
    alpine:3.4 \
    sh