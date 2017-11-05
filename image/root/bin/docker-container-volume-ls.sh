#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --title)
            TITLE="${2}" &&
                shift 2
        ;;
        --destination)
            DESTINATION="${2}" &&
                shift 2
        ;;
        *)
            echo Unknown Option &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"${DESTINATION}\" }}{{ .Name }}{{ end }}{{ end }}" $(docker-container-ls-title --title "${TITLE}")