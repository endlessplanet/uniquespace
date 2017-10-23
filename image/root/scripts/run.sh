#!/bin/sh

apk update &&
    apk upgrade &&
    apk add --no-cache bash sudo coreutils libxslt nano &&
    cp /opt/docker/etc/sudo.txt /etc/sudoers.d/user &&
    adduser -D user &&
    mkdir /home/user/bin &&
    ls -1 /opt/docker/bin | while read FILE
    do
        cp /opt/docker/bin/${FILE} /home/user/bin/${FILE%.*} &&
            chmod 0500 /home/user/bin/${FILE%.*}
    done &&
    chown -R user:user /home/user/bin &&
    ln -sf /home/user/bin/bashrc /home/user/.bashrc &&
    mkdir /etc/docker &&
    mkdir /etc/docker/plugins &&
    cp /opt/docker/plugins/myplugin.json /etc/docker/plugins &&
    rm -rf /var/cache/apk/*