#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        alpine)
            shift &&
                uniquespace-docker-image-build-alpine "${@}" &&
                shift ${#}
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    cd $(mktemp -d) &&
        sed \
            -e "s#\${PACKAGE_NAME}#${PACKAGE_NAME}#" \
            -e "s#\${PROGRAM_NAME}#${PROGRAM_NAME}#" \
            -e "wDockerfile" \
            /opt/docker/src/docker/alpine/Dockerfile &&
        docker build image --label expiry .