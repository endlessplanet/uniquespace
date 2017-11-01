#!/bin/sh

docker container ls --quiet --all --filter "label=title=${@}"