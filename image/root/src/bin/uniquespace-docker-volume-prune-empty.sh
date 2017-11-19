#!/bin/sh

uniquespace docker volume ls empty | while read VOLUME
do
    docker volume rm ${VOLUME}
done