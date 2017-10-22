#!/bin/sh

xsltproc --stringparam expiry $(($(date +%s)-4*7*24*60*60)) /opt/docker/etc/candidates.xslt.xml survey.xml