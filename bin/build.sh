#!/bin/sh

cd image &&
    docker image build --tag endlessplanet/uniquespace:$(git rev-parse --verify HEAD) .