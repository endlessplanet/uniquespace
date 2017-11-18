#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        create)
            shift &&
                uniquespace-docker-volume-create "${@}" &&
                shift ${#}
        ;;
        prune)
            shift &&
                uniquespace-docker-volume-prune "${@}" &&
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