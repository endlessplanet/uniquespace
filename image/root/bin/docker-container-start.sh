#!/bin/sh

docker container ls --all --quiet --filter label=title=${TITLE} | while read CONTAINER
do
    docker container start --interactive ${CONTAINER}
done