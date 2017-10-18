#!/bin/sh

docker container run --interactive --tty --rm docker build --tag endlessplanet/uniquespace:$(git rev-parse --verify HEAD)