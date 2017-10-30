FROM alpine:3.4
LABEL maintainer="${MAINTAINER}" expiry="${EXPIRY}"
RUN \
    apk update && \
    apk upgrade && \
    apk add --no-cache "${PACKAGE_NAME}" && \
    adduser -D user && \
    rm -rf /var/cache/apk/*
USER user
VOLUME ["/home"]
VOLUME ["usr", "local", "bin"]
VOLUME ["usr", "local", "sbin"]
VOLUME ["etc", "sudoers.d"]
WORKDIR /home/user
ENTRYPOINT ["${ENTRYPOINT}"] &&
CMD ["${COMMAND}"]