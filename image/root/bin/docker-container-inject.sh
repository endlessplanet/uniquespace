#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --title)
            TITLE="${2}" &&
                shift 2
                ;;
        *)
            echo Unknown Option &&
                echo ${@} &&
                exit 64
                ;;
    esac
done &&
    docker container ls --quiet --filter "title=${TITLE}" | while read CONTAINER
    do
        docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/home\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER} &&
            docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/usr/local/bin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER} &&
            docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/usr/local/sbin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER} &&
            docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/etc/sudoers.d\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}
    done