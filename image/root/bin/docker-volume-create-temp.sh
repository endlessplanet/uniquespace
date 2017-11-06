#!/bin/sh

docker volume create --label expiry=$(date --date now +%s)