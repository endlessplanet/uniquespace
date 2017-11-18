#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --expiry)
            EXPIRY=${2} &&
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
    docker \
        volume \
        create \
        --label expiry=$(date --date "${EXPIRY}" +%s) \
        --label commit-id=${COMMIT_ID}