FROM alpine:3.4
RUN \
    apk update && \
    apk upgrade && \
    apk add --no-cache sudo && \
    apk add --no-cache docker && \
    apk add --no-cache "${PACKAGE_NAME}" && \
    adduser -D user && \
    mkdir /opt && \
    mkdir /opt/uniquespace && \
    mkdir /opt/uniquespace/bin && \
    mkdir /opt/uniquespace/sbin && \
    mkdir /opt/uniquespace/docker && \
    echo -en "#!/bin/sh\n\nPATH=\${PATH}:/opt/uniquespace/bin" > /home/user/.bashrc && \
    chmod 0644 /home/user/.bashrc && \
    chown user:user /home/user/.bashrc && \
    rm -rf /var/cache/apk/*
USER user
VOLUME ["/home", "/opt/uniquespace/bin", "/opt/uniquespace/sbin", "/opt/uniquespace/docker" "/etc/sudoers.d"]
WORKDIR /home/user
ENTRYPOINT [${ENTRYPOINT}] &&
CMD [${COMMAND}]
LABEL maintainer="${MAINTAINER}" expiry="${EXPIRY}" title="${TITLE}"
