#!/bin/sh

docker-container-create-alpine \
    --title "fit100" \
    --maintainer "Emory Merryman" \
    --package-name bash \
    --entrypoint bash \
    --expiry "now"