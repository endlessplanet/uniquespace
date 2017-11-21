FROM alpine:3.4
RUN \
    apk update && \
    apk upgrade && \
    adduser -d user && \
    apk add --no-cache ${PACKAGE_NAME} && \
    rm -rf /var/cache/apk/*
USER user
WORKDIR /home/user
ENTRYPOINT ["${PROGRAM_NAME}"]
CMD []