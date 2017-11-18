#!/bin/sh

docker container ls --quiet --all --filter label=commit-id | while read CONTAINER
do
    [ "${COMMIT_ID}" != "$(docker container inspect --format "{{index .Config.Labels \"commit-id\"}}" ${CONTAINER})" ] &&
        docker container stop ${CONTAINER} &&
        docker container rm --volumes ${CONTAINER}
done