#!/bin/sh

for VOLUME in $(docker volume ls --quiet)
do
    SIZE=$(docker container run --interactive --rm --mount type=volume,source=${VOLUME},destination=/volume,readonly=true alpine:3.4 du -d0 /volume | cut -f1) &&
        echo -e "${VOLUME}\t${SIZE}"
done | sort -n -k2 > /tmp/volumes.txt