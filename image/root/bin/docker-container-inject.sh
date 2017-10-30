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
    TEMPDIR=$(mktemp -d) &&
    cp /opt/docker/lib/inject/bin.sh ${TEMPDIR}/bin.sh &&
    cp /opt/docker/lib/inject/sbin.sh ${TEMPDIR}/sbin.sh &&
    cp /opt/docker/lib/inject/user.sudo ${TEMPDIR}/user.sudo &&
    docker container ls --quiet --all --filter "label=title=${TITLE}" | while read CONTAINER
    do
        docker container cp ${TEMPDIR}/bin.sh ${CONTAINER}:/usr/local/bin/bin.sh &&
        docker container cp ${TEMPDIR}/bin.sh ${CONTAINER}:/usr/local/bin/bin.sh &&
        docker container cp ${TEMPDIR}/bin.sh ${CONTAINER}:/usr/local/bin/bin.sh &&
    done