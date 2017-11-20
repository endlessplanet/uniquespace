#!/bin/sh

docker volume ls --quiet > ${HOME}/depthcharge-0.txt &&
    NOW=$(date) &&
    seq 1 52 | while read I
    do
        for VOLUME in $(cat ${HOME}/depthcharge-$((${I}-1)).txt)
        do
            CONTAINERS=$(docker container ls --quiet --filter volume=${VOLUME}) &&
            if [ -z "${CONTAINERS}" ]
            then
                echo ${I} 10 ${VOLUME} &&
                TEMP=$(mktemp) &&
                    (cat <<EOF
find /volume -mindepth 1 | while read FILE
do
    stat -c "%X" "\${FILE}" &&
        stat -c "%Y" "\${FILE}" &&
        stat -c "%Z" "\${FILE}"
    done
EOF
                    ) | docker \
                        container \
                        run \
                        --interactive \
                        --rm \
                        --mount type=volume,src=${VOLUME},destination=/volume,readonly=true \
                        alpine:3.4 | sort -un | tail -n 1 > ${TEMP} &&
                    echo ${I} 20 ${VOLUME} &&
                    OLDEST=$(cat ${TEMP}) &&
                    echo ${I} 30 ${VOLUME} &&
                    rm -f ${TEMP} &&
                    echo ${I} 40 ${VOLUME} ${OLDEST} &
                    if [ ! -z "${OLDEST}" ] && [ ${OLDEST} -lt $(date --date "${NOW} - ${I} weeks" +%s) ]
                    then
                        echo ${VOLUME} > ${HOME}/depthcharge-${I}.txt
                    fi &&
                    echo ${I} 50 ${VOLUME} ${OLDEST}
            fi
        done
    done