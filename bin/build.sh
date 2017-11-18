#!/bin/sh

git diff --exit-code &&
    git diff --cached --exit-code &&
    [ -z "$(git ls-files --other --exclude-standard --directory)" ] &&
    cd image &&
    docker build --tag endlessplanet/uniquespace:$(git rev-parse HEAD) .