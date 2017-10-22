#!/bin/sh

for FILE in $(find /srv -mindepth 1)
do
    stat -c "<file volume=\"$(echo ${FILE} | cut -f3 -d "/")\" path=\"$(echo /$(echo ${FILE} | cut -f4 -d "/"))\" lastAccessed=\"%X\" lastModified=\"%Y\" lastChanged=\"%Z\" size=\"%s\"/>" ${FILE}
done &&
    for DU in $(du -d2 /srv)
    do
        VOLUME=$(echo ${DU} | cut -f2 | cut -f2 -d "/") &&
            SIZE=$(echo ${DU} | cut -f1) &&
            echo "<du volume=\"${VOLUME}\" size=\"${SIZE}\"/>"
    done