#!/bin/sh

xsltproc --stringparam expiry $(($(date +%s)-4*7*24*60*60)) candidates.xslt.xml survey.xml