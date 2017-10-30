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
    PROGRAM_NAME="git" &&
    docker container ls --quiet --all --filter "label=title=${TITLE}" | while read CONTAINER
    do
        HOME=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/home\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            BIN=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/usr/local/bin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            SBIN=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/usr/local/sbin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            SUDO=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/etc/sudoers.d\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            sed \
                -e "s#\${PROGRAM_NAME}#${PROGRAM_NAME}" /opt/docker/lib/inject/bin.sh | docker \
                container \
                run \
                --interactive \
                --rm \
                --volume ${BIN}:/usr/local/bin \
                --workdir /usr/local/bin \
                alpine:3.4 \
                tee \
                    ${PROGRAM_NAME}
            
    done