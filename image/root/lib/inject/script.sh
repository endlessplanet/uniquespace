#!/bin/sh

docker container create --interactive --tty --rm "${IMAGE}" "${ARGUMENTS}" &&
    