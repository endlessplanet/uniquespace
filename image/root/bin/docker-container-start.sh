#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --title)
            TITLE=$(docker-container-ls-title --title "${2}") &&
                shift 2
        ;;
        --interactive)
            shift &&
                INTERACTIVE="--interactive"
        ;;
        *)
            echo Unknown Option &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    docker container start ${INTERACTIVE} ${TITLE}
