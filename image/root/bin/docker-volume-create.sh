#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --title)
            title="${2}" &&
                shift 2
        ;;
        --expiry)
            EXPIRY="${2}" &&
                shift 2
        ;;
    esac
done &&
    docker \
        volume \
        create \
        --label "title=${TITLE}" \
        --label "expiry=$(date -d "${EXPIRY}" +%s)"