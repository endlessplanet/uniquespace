#!/bin/sh

echo -n "lastAccessed=\"" &&
    find /volume -mindepth 1 | while read FILE
    do
        stat -c %X "${FILE}"
    done | sort -n | tail -n 1 &&
    echo -n "\" " &&
    echo -n "lastModified=\"" &&
    find /volume -mindepth 1 | while read FILE
    do
        stat -c %Y "${FILE}"
    done | sort -n | tail -n 1 &&
    echo -n "\" " &&
    echo -n "lastChanged=\"" &&
    find /volume -mindepth 1 | while read FILE
    do
        stat -c %Z "${FILE}"
    done | sort -n | tail -n 1 &&
    echo -n "\" " &&
    echo -n "size=\"" &&
    du -d0 /volume | cut -f1 &&
    echo -n "\"" &&
    echo ">"