FROM alpine:3.4
LABEL maintainer="${MAINTAINER}" expiry="${EXPIRY}"
RUN \
    apk update && \
    apk upgrade && \
    apk add --no-cache "${PACKAGE_NAME}" && \
    adduser -D user && \
    rm -rf /var/cache/apk/*
USER user
VOLUME /home
WORKDIR /home/user
ENTRYPOINT ["${ENTRYPOINT}"] &&
CMD ["${COMMAND}"]