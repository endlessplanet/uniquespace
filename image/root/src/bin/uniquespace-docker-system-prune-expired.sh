#!/bin/sh

uniquespace docker container prune expired &&
    uniquespace docker volume prune expired