#!/bin/sh

docker volume ls --quiet --filter label=commit-id | while read VOLUME
do
    if [ "${COMMIT_ID}" != "$(docker volume inspect --format "{{index .Labels \"commit-id\"}}" ${VOLUME})" ]
    then
        docker volume rm ${VOLUME}
    fi
done