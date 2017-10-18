#!/bin/sh

for VOLUME in $(docker volume ls --quiet)
do
    FILES=$(docker \
        container \
        run \
        --interactive \
        --rm \
        --mount type=volume,source=${VOLUME},destination=/volume,readonly=true \
        --workdir /volume \
        alpine:3.4 \
            find \
            . \
            -mindepth 1) &&
        for FILE in ${FILES}
            do
                docker \
                    container \
                    run \
                    --interactive \
                    --rm \
                    --mount type=volume,source=${VOLUME},destination=/volume,readonly=true \
                    --workdir /volume \
                    alpine:3.4 \
                        stat \
                        -c %X \
                        ${FILE}
            done | sort -n -r | head -n 1
done