#!/bin/sh

while [ ${#} -gt 0 ]
do
    case ${1} in
        --maintainer)
            MAINTAINER="${2}" &&
                shift 2
                ;;
        --package-name)
            PACKAGE_NAME="${2}" &&
                shift 2
                ;;
        --entrypoint)
            ENTRYPOINT="${2}" &&
                shift 2
                ;;
        --command)
            shift &&
                COMMAND="${@}" &&
                shift ${#}
                ;;
        --expiry)
            EXPIRY=$(date --date "${2}" +%s) &&
                shift 2
                ;;
        *)
            echo UNSUPPORTED OPTION &&
                echo ${@} &&
                exit 64
                ;;
    esac
done &&
    cd $(mktemp -d) &&
        sed \
            -e "s#\${MAINTAINER}#${MAINTAINER}#" \
            -e "s#\${EXPIRY}#${EXPIRY}#" \
            -e "s#\${PACKAGE_NAME}#${PACKAGE_NAME}#" \
            -e "s#\${ENTRYPOINT}#${ENTRYPOINT}#" \
            -e "s#\${COMMAND}#${COMMAND}#" \
            /opt/docker/lib/docker/alpine/Dockerfile > Dockerfile 2>&1 &&
        docker image build --quiet .