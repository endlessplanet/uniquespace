#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --maintainer)
            MAINTAINER="${2}" &&
                shift 2
                ;;
        --expiry)
            EXPIRY="${2}" &&
                shift 2
                ;;
        *)
            echo UNSUPPORTED OPTION &&
                echo ${@} &&
                exit 64
                ;;
    esac
done &&
    IMAGE=$(docker-image-create-alpine --maintainer "${MAINTAINER}" --package-name bash --entrypoint bash --command "" --expiry "${EXPIRY}")
    docker \
        container \
        --label "maintainer=${MAINTAINER}"
        --label "expiry=$(date --date ${EXPIRY})"
        create \
        --interactive \
        --tty \
        --rm \
        ${IMAGE}