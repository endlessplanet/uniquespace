#!/bin/sh

echo "<survey>" &&
    docker volume ls --quiet | head -n 10 | while read VOLUME
    do
        docker volume inspect ${VOLUME} --format "<inspection driver=\"{{ .Driver }}\" mountpoint=\"{{ .Mountpoint }}\" name={{ .Name }}\" scope=\"{{ .Scope }}\">" &&
            docker volume inspect ${VOLUME} --format '{{ range $k, $v := .Labels -}} <label name="{{ $k }}" value="{{ $v }}" {{ end -}}' &&
            echo "</inspection>"
    done &&
    cat /home/user/bin/inspect-files | docker \
        container \
        run \
        --interactive \
        --rm \
        $(docker volume ls --quiet | head -n 10 | while read VOLUME
            do
                echo "--mount type=volume,source=${VOLUME},destination=/srv/${VOLUME},readonly=true "
            done
        ) \
        alpine:3.4 \
        sh &&
    echo "</survey>"