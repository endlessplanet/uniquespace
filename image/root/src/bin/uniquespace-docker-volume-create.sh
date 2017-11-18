#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        temporary)
            shift &&
                uniquespace docker volume create temporary "${@}" &&
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