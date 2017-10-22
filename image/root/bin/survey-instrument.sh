#!/bin/sh

# echo -n "lastAccessed=\"" &&
#     for FILE in $(find /volume -mindepth 1)
#     do
#         stat -c %X "${FILE}"
#     done | sort -n | tail -n 1 &&
#     echo -n "\" " &&
#     echo -n "lastModified=\"" &&
#     for FILE in $(find /volume -mindepth 1)
#     do
#         stat -c %Y "${FILE}"
#     done | sort -n | tail -n 1 &&
#     echo -n "\" " &&
    echo -n "lastChanged=\"" &&
    for FILE in $(find /volume -mindepth 1)
    do
        stat -c %Z "${FILE}"
    done | sort -n | tail -n 1 &&
    echo -n "\" " &&
    echo -n "size=\"" &&
    du -d0 /volume | cut -f1 &&
    echo -n "\"" &&
    echo ">"