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
done