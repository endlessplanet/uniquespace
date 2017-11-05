#!/bin/sh

docker-container-rm-expired &&
    docker-image-rm-expired &&
    docker-image-build-alpine --title base --package-name bash --entrypoint bash --command &&
    docker-image-build-fedora --title pass --package-name pass --entrypoint pass --command &&
    docker-container-create --interactive --tty --title base --image base &&
    docker-container-inject-run --title base --image pass --program-name pass --container --interactive --tty --rm &&
    docker-container-start --title base --interactive