#!/bin/sh

for FILE in $(find /srv -mindepth 1)
do
    stat -c "<file volume=\"$(echo ${FILE} | cut -f3 -d "/")\" path=\"$(echo /$(echo ${FILE} | cut -f4 -d "/"))\" lastAccessed=\"%X\" lastModified=\"%Y\" lastChanged=\"%Z\" size=\"%s\"/>" ${FILE}
done