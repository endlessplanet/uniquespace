#!/bin/sh

docker volume ls --quiet --all --filter label=commit-id | while read VOLUME
do
    [ "${COMMIT_ID}" != "$(docker volume inspect --format "{{index .Labels \"commit-id\"}}" ${VOLUME})" ] &&
        docker volume rm ${VOLUME}
done