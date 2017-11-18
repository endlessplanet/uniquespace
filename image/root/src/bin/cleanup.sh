#!/bin/sh

uniquespace docker system prune expired &&
    uniquespace docker system prune deprecated