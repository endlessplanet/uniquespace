#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --age)
            AGE=${2} &&
                shift 2
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    for VOLUME in $(docker volume ls --quiet)
    do
        CONTAINERS=$(docker container ls --quiet --filter volume=${VOLUME}) &&
        if [ -z "${CONTAINERS}" ]
        then
            TEMP=$(mktemp) &&
            (cat <<EOF
find /volume -mindepth 1 | while read FILE
do
    stat -c "%X" "\${FILE}"
done
EOF
            ) | docker \
                container \
                run \
                --interactive \
                --rm \
                --mount type=volume,src=${VOLUME},destination=/volume,readonly=true \
                alpine:3.4 | tail -n 1 > ${TEMP} &&
                FIRST=$(cat ${TEMP}) &&
                rm -f ${TEMP} &&
                if [ -z "${FIRST}" ]
                then
                    echo ${VOLUME}
                fi
        fi
    done