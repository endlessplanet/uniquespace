#!/bin/sh

echo -n "lastAccessed=\""
    for FILE in $(find /volume -mindepth 1)
    do
        stat -c %X /volume/${FILE}
    done | sort -nr | head -n 1 &&
    echo -n "\">"