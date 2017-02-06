#!/bin/bash -e
sed -i "s/#MAINTAINER=.*/MAINTAINER=\"$MAINTAINER\"/" /etc/abuild.conf
sed -i "s/#PACKAGER=.*/PACKAGER=\"$PACKAGER\"/" /etc/abuild.conf

chown -R builder: "/home/builder/"
su-exec builder echo 'PACKAGER_PRIVKEY="/home/builder/.abuild/privkey.rsa"' > /home/builder/.abuild/abuild.conf

chown builder: /build
cd /build

apk add \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --update \
    libgdiplus-dev

su-exec builder abuild checksum
su-exec builder abuild -r