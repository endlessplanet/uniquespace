#!/bin/sh

for VOLUME in $(docker volume ls --quiet)
do
    WORK=$(mktemp -d) &&
        aws s3 cp s3://${2}/${VOLUME}.tar.gz.gpg ${WORK}/${VOLUME}.tar.gz.gpg &&
        gpg --decrypt --verify ${WORK}/${VOLUME}.tar.gz.gpg --output ${WORK}/${VOLUME}.tar.gz &&
        gunzip ${WORK}/${VOLUME}.tar.gz &&
        mkdir ${WORK}/${VOLUME} &&
        tar --extract --file ${WORK}/${VOLUME}.tar --directory ${WORK}/${VOLUME} &&
        rm -rf ${WORK}
done