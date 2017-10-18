#!/bin/sh

docker volume ls | while read VOLUME
do
    docker volume inspect ${VOLUME} --format "{{}}"
done