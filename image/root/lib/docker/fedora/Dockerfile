FROM fedora:26
RUN \
    dnf update --assumeyes && \
    dnf install --assumeyes "${PACKAGE_NAME}" && \
    adduser user && \
    dnf update --assumeyes && \
    dnf clean all
USER user
VOLUME ["/home", "/usr/local/bin", "/usr/local/sbin", "/etc/sudoers.d"]
WORKDIR /home/user
ENTRYPOINT [${ENTRYPOINT}] &&
CMD [${COMMAND}]
LABEL maintainer="${MAINTAINER}" expiry="${EXPIRY}" title="${TITLE}"
