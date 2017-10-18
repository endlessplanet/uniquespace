#!/bin/sh

for VOLUME in $(docker volume ls --quiet)
do
    WORK=$(mktemp -d) &&
        mkdir ${WORK}/${VOLUME} &&
        docker inspect ${VOLUME} > ${WORK}/${VOLUME}/inspect.txt &&
        mkdir ${WORK}/${VOLUME}/content &&
        docker container run --interactive --rm --volume ${VOLUME}:/vol:ro --workdir /vol alpine:3.4 tar --create --file - . | tar --extract --file - --directory ${WORK}/${VOLUME}/content &&
        tar --create --file ${WORK}/${VOLUME}.tar --directory ${WORK}/${VOLUME} . &&
        gzip -9 ${WORK}/${VOLUME}.tar &&
        gpg --batch --yes --encrypt --armor --recipient ${1} --output ${WORK}/${VOLUME}.tar.gz.gpg ${WORK}/${VOLUME}.tar.gz &&
        md5sum ${WORK}/${VOLUME}.tar.gz.gpg | cut -b 1-32 > ${WORK}/${VOLUME}.tar.gz.gpg.md5 &&
        aws s3 cp ${WORK}/${VOLUME}.tar.gz.gpg s3://${2}/${VOLUME}.tar.gz.gpg &&
        aws s3 cp ${WORK}/${VOLUME}.tar.gz.gpg.md5 s3://${2}/${VOLUME}.tar.gz.gpg.md5 &&
        rm -rf ${WORK}
done