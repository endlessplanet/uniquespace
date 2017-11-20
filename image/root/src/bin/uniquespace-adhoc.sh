#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        depthcharge)
            shift &&
                uniquespace-adhoc-depthcharge "${@}" &&
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