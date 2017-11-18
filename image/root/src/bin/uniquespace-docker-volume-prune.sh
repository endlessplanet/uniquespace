#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        deprecated)
            uniquespace-docker-volume-prune-deprecated &&
                shift ${#}
        ;;
        expired)
            echo AA00100 &&
                uniquespace-docker-volume-prune-expired &&
                shift ${#} &&
                echo AA00200
        ;;
        *)
            echo Unknown Option &&
                echo ${0} &&
                echo "${@}" &&
                exit 64
        ;;
    esac
done