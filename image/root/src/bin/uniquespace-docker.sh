#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        container)
            shift &&
                uniquespace-docker-container "${@}" &&
                shift ${#}
        ;;
        image)
            shift &&
                uniquespace-docker-image "${@}" &&
                shift ${#}
        ;;
        network)
            shift &&
                uniquespace-docker-network "${@}" &&
                shift ${#}
        ;;
        system)
            shift &&
                uniquespace-docker-system "${@}" &&
                shift ${#}
        ;;
        volume)
            shift &&
                uniquespace-docker-volume "${@}" &&
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