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
    PROGRAM_NAME=docker &&
    docker container ls --quiet --all --filter "label=title=${TITLE}" | while read CONTAINER
    do
        BIN=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/usr/local/bin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            sed \
                -e "s#\${PROGRAM_NAME}#${PROGRAM_NAME}#" \
                /opt/docker/lib/inject/bin.sh | docker \
                container \
                run \
                --interactive \
                --rm \
                --volume ${BIN}:/usr/local/bin \
                --workdir /usr/local/bin \
                alpine:3.4 \
                tee \
                    ${PROGRAM_NAME} &&
            docker container run --interactive --rm --volume ${BIN}:/usr/local/bin --workdir /usr/local/bin alpine:3.4 chmod 0555 ${PROGRAM_NAME}
            SUDO=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/etc/sudoers.d\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            sed \
                -e "s#\${PROGRAM_NAME}#${PROGRAM_NAME}#" \
                /opt/docker/lib/inject/user.sudo | docker \
                container \
                run \
                --interactive \
                --rm \
                --volume ${SUDO}:/etc/sudoers.d \
                --workdir /etc/sudoers.d \
                alpine:3.4 \
                tee \
                    user &&
            docker container run --interactive --rm --volume ${SUDO}:/etc/sudoers.d --workdir /etc/sudoers.d alpine:3.4 chmod 0444 user &&
            SBIN=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/usr/local/sbin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            HOME=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/home\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            (cat <<EOF
#!/bin/sh

docker \
    run \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --volume ${VOLUME}:/var/opt/docker \
    --volume ${HOME}:/home \
    --workdir /home/user \
    --user 500 \
    docker:17.10.0 \
        "${@}"
EOF
            ) | docker container run --interactive --rm --volume ${SBIN}:/usr/local/sbin --workdir /usr/local/sbin alpine:3.4 tee ${PROGRAM_NAME}.sh &&
            docker container run --interactive --rm --volume ${SBIN}:/usr/local/sbin --workdir /usr/local/sbin alpine:3.4 chmod 0500 ${PROGRAM_NAME}.sh
    done