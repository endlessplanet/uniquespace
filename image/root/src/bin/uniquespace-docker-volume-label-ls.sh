#!/bin/sh

docker volume ls --quiet | while read VOLUME
do
    for LABEL in $(docker inspect --format "{{ range \$k, \$v := .Labels -}} {{ \$k }} {{ end -}}\n" ${VOLUME})
    do
        echo ${LABEL}
    done
done | sort -u