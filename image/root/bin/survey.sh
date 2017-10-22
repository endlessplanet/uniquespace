#!/bin/sh

LIMIT=4 &&
    echo "<survey>" &&
    docker volume ls --quiet | head -n ${LIMIT} | while read VOLUME
    do
        echo -n "<volume " &&
            docker volume inspect ${VOLUME} --format "driver=\"{{ .Driver }}\" mountpoint=\"{{ .Mountpoint }}\" name=\"{{ .Name }}\" scope=\"{{ .Scope }}\"" &&
            cat /home/user/bin/survey-instrument | docker \
                container \
                run \
                --interactive \
                --rm \
                --mount type=volume,source=${VOLUME},destination=/volume,readonly=true \
                alpine:3.4 \
                sh &&
            docker volume inspect ${VOLUME} --format '{{ range $k, $v := .Labels -}} <label name="{{ $k }}" value="{{ $v }}"/> {{ end -}}' &&
            docker container ls --quiet --filter volume=${VOLUME} | while read CONTAINER
            do
                echo "<container id=\"${CONTAINER}\"/>"
            done &&
            echo "</volume>"
    done &&
    echo "</survey>"