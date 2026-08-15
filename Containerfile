FROM ubuntu:26.04 AS source

ADD --checksum=sha256:c999c2768537e2d59cfba717de39fd39623ee46be68c5f447daf469becb3e369 https://get.opera.com/pub/opera_gx/134.0.5954.55/linux/opera-gx-stable_134.0.5954.55_amd64.deb /tmp/app.deb

FROM ghcr.io/containerpak/gtk3:main

LABEL org.opencontainers.image.source="https://github.com/Containerpak/opera-gx"

RUN --mount=type=bind,from=source,source=/tmp/app.deb,target=/run/app.deb \
    apt-get update && \
    apt-get install -y --no-install-recommends /run/app.deb && \
    cpak-clean-junk

COPY icon.png /usr/share/icons/hicolor/128x128/apps/opera-gx.png
COPY opera-gx.desktop /usr/share/applications/opera-gx.desktop
