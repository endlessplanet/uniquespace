#!/bin/sh

docker image ls --filter --quiet "label=title=${@}"