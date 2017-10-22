#!/bin/sh

for FILE in $(find /srv -mindepth 1)
do
    stat -c "<file path=\"${FILE}\" lastAccessed=\"%X\" lastModified=\"%Y\" lastChanged=\"%Z\" size=\"last%s\"/>" ${FILE}
done