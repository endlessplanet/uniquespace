#!/bin/sh

docker volume ls --quiet --filter label=name --filter label=description --filter label=expiry | while read VOLUME
do
    NAME="$(docker volume inspect --format \"{{.Labels.name}}\" ${VOLUME})" &&
        DESCRIPTION="$(docker volume inspect --format \"{{.Labels.description}}\" ${VOLUME})" &&
        EXPIRY="$(docker volume inspect --format \"{{.Labels.expiry}}\" ${VOLUME})" &&
        echo -en "${NAME}\t${DESCRIPTION}\t${EXPIRY}"
done