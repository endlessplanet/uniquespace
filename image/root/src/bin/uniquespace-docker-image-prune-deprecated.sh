#!/bin/sh

docker image ls --quiet --filter label=commit-id | while read IMAGE
do
    if [ "${COMMIT_ID}" != "$(docker image inspect --format "{{index .Config.Labels \"commit-id\"}}" ${IMAGE})" ]
    then
        docker volume rm ${IMAGE}
    fi
done