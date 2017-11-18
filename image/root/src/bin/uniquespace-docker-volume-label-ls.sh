#!/bin/sh

docker volume ls --quiet | while read VOLUME
do
    docker inspect --format "{{ range \$k, \$v := .Labels -}} {{ \$k }} {{ end -}}" ${VOLUME}
done | sort -u