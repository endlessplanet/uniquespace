#!/bin/sh

FLAG="default" &&
    while [ ${#} -gt 0 ]
    do
        if [ "${FLAG}" == "entrypoint" ] && [ "${1}" == "--command" ]
        then
            shift &&
                FLAG="command"
        elif [ "${FLAG}" == "entrypoint" ] && [ "${1}" != "--command" ] && [ -z "${ENTRYPOINT}" ]
        then
            ENTRYPOINT="\"${1}\"" &&
                shift
        elif [ "${FLAG}" == "entrypoint" ] && [ "${1}" != "--command" ] && [ ! -z "${ENTRYPOINT}" ]
        then
            ENTRYPOINT=", \"${1}\"" &&
                shift
        elif [ "${FLAG}" == "command" ] && [ -z "${COMMAND}" ]
        then
            COMMAND="\"${1}\"" &&
                shift
        elif [ "${FLAG}" == "command" ] && [ ! -z "${COMMAND}" ]
        then
            COMMAND=", \"${1}\"" &&
                shift
        else
            case ${1} in
                --maintainer)
                    MAINTAINER="${2}" &&
                        shift 2
                        ;;
                --package-name)
                    PACKAGE_NAME="${2}" &&
                        shift 2
                        ;;
                --expiry)
                    EXPIRY=$(date --date "${2}" +%s) &&
                        shift 2
                        ;;
                --entrypoint)
                    shift &&
                        FLAG="entrypoint"
                        ;;
                --command)
                    shift &&
                        FLAG="command"
                        ;;
                *)
                    echo UNSUPPORTED OPTION &&
                        echo ${@} &&
                        exit 64
                        ;;
            esac
        fi
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