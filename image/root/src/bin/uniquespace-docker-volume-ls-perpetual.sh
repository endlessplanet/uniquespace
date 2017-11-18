#!/bin/sh

docker volume ls --quiet | while read VOLUME
do
    EXPIRATION_DATE=$(docker volume inspect --format "{{index .Labels \"expiry\"}}" ${VOLUME}) &&
        CONTAINERS=$(docker container ls --quiet --all --filter volume=${VOLUME}) &&
        if [ -z "${EXPIRATION_DATE}" ] && [ -z "${CONTAINERS}" ]
        then
            echo ${VOLUME}
        fi
done