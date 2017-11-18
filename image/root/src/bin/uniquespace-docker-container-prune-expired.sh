#!/bin/sh

docker container ls --quiet --all --filter label=commit-id | while read CONTAINER
do
    if [ $(date +%s) -gt $(docker container inspect --format "{{index .Config.Labels \"expiry\"}}" ${CONTAINER}) ]
    then
        docker container stop ${CONTAINER} &&
        docker container rm --volumes ${CONTAINER}
    fi
done