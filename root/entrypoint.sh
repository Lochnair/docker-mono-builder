#!/bin/bash -e
sed -i "s/#MAINTAINER=.*/MAINTAINER=\"$MAINTAINER\"/" /etc/abuild.conf
sed -i "s/#PACKAGER=.*/PACKAGER=\"$PACKAGER\"/" /etc/abuild.conf

su-exec builder chown builder: "/home/builder/.abuild/privkey.rsa"
su-exec builder echo 'PACKAGER_PRIVKEY="/home/builder/.abuild/privkey.rsa"' > /home/builder/.abuild/abuild.conf

mkdir /build
chown builder: /build
cd /build

su-exec builder curl -L -O "http://git.alpinelinux.org/cgit/aports/plain/testing/mono/APKBUILD"
su-exec builder curl -L -O "http://git.alpinelinux.org/cgit/aports/plain/testing/mono/arm-remove-sigcontext-include.patch"

su-exec builder sed -i 's/pkgver=.*/pkgver=4.6.2.16/' APKBUILD
su-exec builder sed -i 's/pkgrel=0/pkgrel=1/' APKBUILD

apk add \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
    --update \
    libgdiplus-dev

su-exec builder abuild checksum
su-exec builder abuild -r