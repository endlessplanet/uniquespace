#!/bin/sh

docker-container-create-alpine \
    --title "fit" \
    --maintainer "Emory Merryman" \
    --package-name bash \
    --entrypoint bash \
    --expiry "now"