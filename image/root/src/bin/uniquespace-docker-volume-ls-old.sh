#!/bin/sh

echo ARGS ${#} ${@} &&
while [ ${#} -gt 0 ]
do
    case ${1} in
        --cutoff)
            echo FUCKERS &&
                export CUTOFF="${2}" &&
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
                OLDEST=$(cat ${TEMP}) &&
                rm -f ${OLDEST} &&
                if [ ! -z "${OLDEST}" ] && [ ${OLDEST} -lt $(date --date "${CUTOFF}" +%s) ]
                then
                    echo ${VOLUME} ${OLDEST} ${CUTOFF} $(date --date "${CUTOFF}" +%s)
                fi
        fi
    done