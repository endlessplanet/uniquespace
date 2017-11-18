#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        perpetual)
            shift &&
                uniquespace-docker-volume-ls-perpetual &&
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