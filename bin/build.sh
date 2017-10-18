#!/bin/sh

cd image &&
    docker build --tag endlessplanet/uniquespace:$(git rev-parse --verify HEAD) .