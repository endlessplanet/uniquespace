#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        adhoc)
            shift &&
                uniquespace-adhoc "${@}" &&
                shift ${#}
        ;;
        docker)
            shift &&
                uniquespace-docker "${@}" &&
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