#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --name)
            NAME="${2}" &&
                shift 2
        ;;
        --description)
            DESCRPTION="${2}" &&
                shift 2
        ;;
        --persistence)
            PERSISTENCE="${3}" &&
                shift 2
        ;;
    esac
done &&
    docker \
        volume \
        create \
        --label "name=${NAME}" \
        --label "description=${DESCRIPTION}" \
        --label "persistence=${PERSISTENCE}" \
        --label "tstamp=$(date +%s)"