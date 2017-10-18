#!/bin/sh

docker volume ls --quiet | while read VOLUME
do
    LAST_READ=$(docker \
        container \
        run \
        --interactive \
        --rm \
        --mount type=volume,source=${VOLUME},destination=/volume,readonly=true \
        --workdir /volume \
        alpine:3.4 \
            find \
            . \
            -mindepth 1 | while read FILE
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
                        "${FILE}"
            done | sort -n -r | head -n 1) &&
        LAST_WRITE=$(docker \
            container \
            run \
            --interactive \
            --rm \
            --mount type=volume,source=${VOLUME},destination=/volume,readonly=true \
            --workdir /volume \
            alpine:3.4 \
                find \
                . \
                -mindepth 1 | while read FILE
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
                            -c %Y \
                            "${FILE}"
                done | sort -n -r | head -n 1) &&
        SIZE=$(docker \
            container \
            run \
            --interactive \
            --rm \
            --mount type=volume,source=${VOLUME},destination=/volume,readonly=true \
            --workdir /volume \
            alpine:3.4 \
                du \
                -d1 \
                /volume | cut -f1) &&
        echo -e "${VOLUME}\t${LAST_READ}\t${LAST_WRITE}\t${SIZE}"
done