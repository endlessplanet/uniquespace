#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        build)
            shift &&
                uniquespace-docker-image-build "${@}" &&
                shift ${#}
        ;;
        label)
            shift &&
                uniquespace-docker-image-label "${@}" &&
                shift ${#}
        ;;
        prune)
            shift &&
                uniquespace-docker-image-prune "${@}" &&
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