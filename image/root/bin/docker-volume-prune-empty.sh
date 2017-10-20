#!/bin/sh

docker volume ls --quiet | while read VOLUME
do
    SIZE=$(docker container run --interactive --tty --rm --mount type=volume,source=${VOLUME},destination=/volume,readonly=true alpine:3.4 du -d0 /volume) &&
    echo -e "${VOLUME}\t${SIZE}"
done