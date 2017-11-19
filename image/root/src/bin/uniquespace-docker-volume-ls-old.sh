#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --cutoff)
            CUTOFF=${2} &&
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
            OLDEST=$((cat <<EOF
    find /volume -mindepth 1 | while read FILE
    do
        LAST_ACCESSED=\$(stat -c "%X" "\${FILE}") &&
            if [ $(date --date "2000-01-01" +%s) -lt \${LAST_ACCESSED} ] && [ \${LAST_ACCESSED} -lt $(date --date "2030-01-01" +%s) ]
            then
                echo \${LAST_ACCESSED}
            fi
            LAST_MODIFIED=\$(stat -c "%Y" "\${FILE}") &&
            if [ $(date --date "2000-01-01" +%s) -lt \${LAST_MODIFIED} ] && [ \${LAST_MODIFIED} -lt $(date --date "2030-01-01" +%s) ]
            then
                echo \${LAST_MODIFIED}
            fi
            LAST_CHANGED=\$(stat -c "%Z" "\${FILE}")
            if [ $(date --date "2000-01-01" +%s) -lt \${LAST_CHANGED} ] && [ \${LAST_CHANGED} -lt $(date --date "2030-01-01" +%s) ]
            then
                echo \${LAST_CHANGED}
            fi
    done
EOF
            ) | docker \
                container \
                run \
                --interactive \
                --rm \
                --mount type=volume,src=${VOLUME},destination=/volume,readonly=true \
                alpine:3.4 | sort -un | tail -n 1) &&
                if [ ! -z "${OLDEST}" ] && [ ${OLDEST} -lt $(date --date "${CUTOFF}" +%s) ]
                then
                    echo ${VOLUME} ${OLDEST} $(date --date @${OLDEST})
                fi
        fi
    done