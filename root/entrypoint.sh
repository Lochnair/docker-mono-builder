#!/bin/bash -e
sed -i "s/#MAINTAINER=.*/MAINTAINER=\"$MAINTAINER\"/" /etc/abuild.conf
sed -i "s/#PACKAGER=.*/PACKAGER=\"$PACKAGER\"/" /etc/abuild.conf

su-exec builder mkdir /home/builder/.abuild
su-exec builder echo "$PRIV_KEY" > /home/builder/.abuild/privkey.rsa
su-exec builder echo 'PACKAGE_PRIVKEY="/home/builder/.abuild/privkey.rsa"' > /home/builder/.abuild/abuild.conf

mkdir /build
chown builder: /build
cd /build

su-exec builder curl -L -O "http://git.alpinelinux.org/cgit/aports/plain/testing/mono/APKBUILD"
su-exec builder curl -L -O "http://git.alpinelinux.org/cgit/aports/plain/testing/mono/arm-remove-sigcontext-include.patch"

su-exec builder sed -i 's/pkgver=.*/pkgver=4.6.2.16/' APKBUILD
su-exec builder sed -i 's/pkgrel=0/pkgrel=1/'

su-exec builder abuild rootpkg