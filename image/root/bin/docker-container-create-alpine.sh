#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --title)
            TITLE="${2}" &&
            shift 2
            ;;
        --maintainer)
            MAINTAINER="${2}" &&
                shift 2
                ;;
        --package-name)
            PACKAGE_NAME="${2}" &&
                shift 2
                ;;
        --expiry)
            EXPIRY="${2}" &&
                shift 2
                ;;
        --entrypoint)
            ENTRYPOINT="${2}" &&
                shift 2
                ;;
        --command)
            shift &&
                COMMAND="${@}" &&
                shift ${#}
                ;;
        *)
            echo UNSUPPORTED OPTION &&
                echo ${@} &&
                exit 64
                ;;
    esac
done &&
    IMAGE=$(docker-image-create-alpine \
        --maintainer "${MAINTAINER}" \
        --package-name "${PACKAGE_NAME}" \
        --entrypoint "${ENTRYPOINT}" \
        --command "${COMMAND}" \
        --expiry "${EXPIRY}"
    ) &&
    docker \
        container \
        create \
        --label expiry=$(date --date "${EXPIRY}" +%s) \
        --label "title=${TITLE}" \
        --interactive \
        --tty \
        --rm \
        ${IMAGE}