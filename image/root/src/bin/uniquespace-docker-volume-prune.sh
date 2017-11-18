#!/bin/sh

fixit(){
    echo FUCK IT &&
        exit 65
}
    trap fixit EXIT &&
    while [ ${#} -gt 0 ]
    do
        case ${1} in
            deprecated)
                uniquespace-docker-volume-prune-deprecated &&
                    shift ${#}
            ;;
            expired)
                echo AA00100 ${@} &&
                    uniquespace-docker-volume-prune-expired &&
                    echo AA00200 ${@} &&
                    shift ${#} &&
                    echo AA00300 ${@}
            ;;
            *)
                echo Unknown Option &&
                    echo ${0} &&
                    echo "${@}" &&
                    exit 64
            ;;
        esac
    done