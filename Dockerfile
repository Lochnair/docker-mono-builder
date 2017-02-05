FROM alpine:3.5
MAINTAINER Lochnair <me@lochnair.net>

LABEL Description="Mono APK builder image (Alpine)"

ENV MONO_VERSION "4.6.2.16"

RUN \
apk add \
    --no-cache \
    --update \
    alpine-sdk \
    sudo

RUN \
adduser -D -G abuild -s /bin/sh builder

COPY root/ /