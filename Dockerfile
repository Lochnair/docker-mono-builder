FROM alpine:3.5
MAINTAINER Lochnair <me@lochnair.net>

LABEL Description="Mono APK builder image (Alpine)"

ENV MONO_VERSION "4.6.2.16"

ENV PACKAGER "Your Name <your@emailaddress>"
ENV PRIV_KEY "# INVALID KEY #"
ENV MAINTAINER "${PACKAGER}"

RUN \
apk add \
    --no-cache \
    --update \
    alpine-sdk \
    bash \
    curl \
    git \
    su-exec \
    sudo

RUN \
adduser -D -G abuild -s /bin/sh builder && \
mkdir /home/builder/.abuild

RUN \
mkdir -p /var/cache/distfiles && \
chmod a+w /var/cache/distfiles

COPY root/ /

RUN \
chmod +x /entrypoint.sh

VOLUME /home/builder/packages

ENTRYPOINT ["/entrypoint.sh"]