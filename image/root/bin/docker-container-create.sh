#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --title)
            TITLE="${2}" &&
                shift 2
            ;;
        --expiry)
            EXPIRY="${2}" &&
                shift 2
                ;;
        --image)
            IMAGE="$(docker-image-ls-title --title ${2})" &&
                shift 2
                ;;
        --interactive)
            INTERACTIVE="--interactive" &&
                shift
                ;;
        --tty)
            TTY="--tty" &&
                shift
                ;;
        --rm)
            RM="--rm" &&
                shift
                ;;
        *)
            echo UNSUPPORTED OPTION &&
                echo ${@} &&
                exit 64
                ;;
    esac
done &&
    docker container ls --quiet --filter "label=title=${TITLE}" | while read CONTAINER
    do
        echo Duplicate Title ${TITLE} &&
            exit 65
    done &&
    if [ -z "${IMAGE}" ]
    then
        echo Undefined Image &&
            exit 66
    fi &&
    docker \
        container \
        create \
        --label expiry=$(date --date "${EXPIRY}" +%s) \
        --label "title=${TITLE}" \
        ${INTERACTIVE} \
        ${TTY} \
        ${RM} \
        ${IMAGE}