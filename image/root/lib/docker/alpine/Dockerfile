FROM alpine:3.4
RUN \
    apk update && \
    apk upgrade && \
    apk add --no-cache sudoe && \
    apk add --no-cache "${PACKAGE_NAME}" && \
    adduser -D user && \
    rm -rf /var/cache/apk/*
USER user
VOLUME ["/home", "/usr/local/bin", "/usr/local/sbin", "/etc/sudoers.d"]
WORKDIR /home/user
ENTRYPOINT [${ENTRYPOINT}] &&
CMD [${COMMAND}]
LABEL maintainer="${MAINTAINER}" expiry="${EXPIRY}" title="${TITLE}"
