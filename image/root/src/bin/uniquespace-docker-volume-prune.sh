#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        deprecated)
            uniquespace-docker-volume-prune-deprecated &&
                shift ${#}
        ;;
        expired)
            uniquespace-docker-volume-prune-expired &&
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