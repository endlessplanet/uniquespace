#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --name)
            NAME="${2}" &&
                shift 2
        ;;
        --description)
            DESCRIPTION="${2}" &&
                shift 2
        ;;
        --expiry)
            EXPIRY=$(date -d "${2}" +%s) &&
                shift 2
        ;;
    esac
done &&
    docker \
        volume \
        create \
        --label "name=${NAME}" \
        --label "description=${DESCRIPTION}" \
        --label "expiry=${EXPIRY}"