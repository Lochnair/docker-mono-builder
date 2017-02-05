#!/bin/bash -e
sed -i "s/#MAINTAINER=.*/MAINTAINER=\"$MAINTAINER\"/" /etc/abuild.conf
sed -i "s/#PACKAGER=.*/PACKAGER=\"$PACKAGER\"/" /etc/abuild.conf

echo "$PRIV_KEY" > /home/builder/.abuild/privkey.rsa
echo 'PACKAGE_PRIVKEY="/home/builder/.abuild/privkey.rsa"' > /home/builder/.abuild/abuild.conf

mkdir /build
cd /build

curl -L -O "http://git.alpinelinux.org/cgit/aports/plain/testing/mono/APKBUILD"
curl -L -O "http://git.alpinelinux.org/cgit/aports/plain/testing/mono/arm-remove-sigcontext-include.patch"

sed -i 's/pkgver=.*/pkgver=4.6.2.16/' APKBUILD
sed -i 's/pkgrel=0/pkgrel=1/'

abuild rootpkg