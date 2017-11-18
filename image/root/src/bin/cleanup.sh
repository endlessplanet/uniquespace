#!/bin/sh

export PATH=/opt/docker/bin:${PATH} &&
    uniquespace docker system prune expired &&
    uniquespace docker system prune deprecated