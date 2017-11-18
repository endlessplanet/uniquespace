#!/bin/sh

docker volume ls --quiet | while read VOLUME
do
    EXPIRATION_DATE=$(docker volume inspect --format "{{index .Labels \"expiry\"}}" ${VOLUME}) &&
        if [ -z "${EXPIRATION_DATE}" ]
        then
            echo ${VOLUME}
        fi
done