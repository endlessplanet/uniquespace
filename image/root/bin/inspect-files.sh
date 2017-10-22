#!/bin/sh

for FILE in $(find /srv -mindepth 1)
do
    stat -c "<file volume=\"$(echo ${FILE} | cut -f2 -d "/")\" path=\"$(echo ${FILE} | cut -f2 -d "/")\" lastAccessed=\"%X\" lastModified=\"%Y\" lastChanged=\"%Z\" size=\"last%s\"/>" ${FILE}
done