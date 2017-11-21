#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        deprecated)
            uniquespace-docker-image-prune-deprecated &&
                shift ${#}
        ;;
        expired)
            uniquespace-docker-image-prune-expired &&
                shift ${#}
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo "${@}" &&
                exit 64
        ;;
    esac
done