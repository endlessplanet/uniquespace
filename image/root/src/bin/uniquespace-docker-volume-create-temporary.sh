#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --expiry)
            EXIPRY=${2} &&
                shift
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    docker volume create --label expiry=$(date --date "${EXPIRY}" +%s)