#!/bin/sh

apk update &&
    apk upgrade &&
    adduser -D user &&
    apk add --no-cache bash sudo &&
    echo "user ALL=(ALL) NOPASSWD: /usr/local/bin/docker" > /etc/sudoers.d/user &&
    chmod 0444 /etc/sudoers.d/user &&
    mkdir /opt/docker/bin &&
    ls -1 /opt/docker/src/bin | while read FILE
    do
        cp /opt/docker/src/bin/${FILE} /opt/docker/bin/${FILE%.*} &&
            chmod 0555 /opt/docker/bin/${FILE%.*}
    done &&
    echo "export PATH=/opt/docker/bin:\${PATH}" >> /home/user/.bashrc &&
    rm -rf /var/cache/apk/*