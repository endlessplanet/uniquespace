#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        ls)
            shift &&
                uniquespace-docker-volume-label-ls &&
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