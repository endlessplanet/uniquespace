#!/bin/sh

(cat <<EOF
for FILE in find /srv -mindepth 1
do
    stat -c "${FILE}\t%X\t%Y\t%Z" ${FILE}
done
EOF
) | docker
    container \
    run \
    --interactive \
    --tty \
    --rm \
    $(docker volume ls --quiet | head -n 100 | while read VOLUME
        do
            echo "--mount type=volume,source=${VOLUME},destination=/srv/${VOLUME},readonly=true "
        done
    ) \
    alpine:3.4 \
    sh