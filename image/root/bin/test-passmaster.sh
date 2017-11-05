#!/bin/sh

docker-image-build-fedora --title pass --package-name pass --entrypoint pass --command &&
    docker-image-build-alpine --title gpgme --package-name gpgme --entrypoint gpg --command &&
    docker-image-build-alpine --title findutils --package-name findutils --entrypoint find --command &&
    docker-container-create --interactive --tty --title pass --image pass &&
    docker-container-create --interactive --tty --title gpgme --image gpgme &&
    docker-container-create --interactive --tty --title findutils --image findutils &&
    docker-container-inject-run --title pass --image findutils