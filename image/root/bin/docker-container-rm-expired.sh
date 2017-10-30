#!/bin/sh

docker container ls --quiet --filter label=expiry | while read CONTAINER
do
    [ $(date +%s) -gt $(docker container inspect ${CONTAINER} --format "{{index .Config.Labels \"expiry\"}}") ] &&
        [ "$(docker container inspect --format \"{{ .State.Status }}\")" != "running" ] &&
        docker container rm --volumes ${CONTAINER}
done