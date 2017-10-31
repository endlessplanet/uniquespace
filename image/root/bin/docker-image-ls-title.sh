#!/bin/sh

docker image ls --filter "label=title=${@}"