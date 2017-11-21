#!/bin/sh

docker image ls --quiet | while read IMAGE
do
    for LABEL in $(docker image inspect --format "{{ range \$k, \$v := .Config.Labels -}} {{ \$k }} {{ end -}}\n" ${IMAGE})
    do
        echo ${LABEL}
    done
done | sort -u