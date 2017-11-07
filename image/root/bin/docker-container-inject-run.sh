#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --program-name)
            PROGRAM_NAME="${2}" &&
                shift 2
        ;;
        --title)
            TITLE="${2}" &&
                shift 2
        ;;
        --image)
            IMAGE=$(docker-image-ls-title --title "${2}") &&
                shift 2
        ;;
        --container)
            shift &&
                CONTAINER_ARGUMENTS="${@}" &&
                shift ${#}
        ;;
        *)
            echo Unknown Option &&
                echo ${@} &&
                exit 64
        ;;
    esac
done &&
    docker container ls --quiet --all --filter "label=title=${TITLE}" | while read CONTAINER
    do
        BIN=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/opt/uniquespace/bin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
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
            SBIN=$(docker container inspect --format "{{ range .Mounts }}{{ if eq .Destination \"/opt/uniquespace/sbin\" }}{{ .Name }}{{ end }}{{ end }}" ${CONTAINER}) &&
            (cat <<EOF
#!/bin/sh

CIDFILE=\$(mktemp /opt/uniquespace/docker/XXXXXXXX) &&
    rm -f \${CIDFILE} &&
    docker container create --cidfile \${CIDFILE} ${CONTAINER_ARGUMENTS} ${IMAGE} &&
    docker container start --interactive \$(cat \${CIDFILE})
EOF
            ) | docker container run --interactive --rm --volume ${SBIN}:/usr/local/sbin --workdir /usr/local/sbin alpine:3.4 tee ${PROGRAM_NAME}.sh &&
            docker container run --interactive --rm --volume ${SBIN}:/usr/local/sbin --workdir /usr/local/sbin alpine:3.4 chmod 0500 ${PROGRAM_NAME}.sh
    done