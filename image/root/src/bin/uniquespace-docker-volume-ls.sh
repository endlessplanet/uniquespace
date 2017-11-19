#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        empty)
            shift &&
                uniquespace-docker-volume-ls-empty "${@}" &&
                shift ${#}
        ;;
        perpetual)
            shift &&
                uniquespace-docker-volume-ls-perpetual "${@}" &&
                shift ${#}
        ;;
        old)
            shift &&
                uniquespace-docker-volume-ls-old "${@}" &&
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