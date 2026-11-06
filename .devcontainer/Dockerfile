FROM debian:trixie-slim AS build

ARG ALGOTYPST_REPO=https://github.com/tudalgo/AlgoTypst.git
ARG ALGOTYPST_REF=main
ARG TYPST_VERSION=0.15.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl pdf2svg python3 python3-toml unzip xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work

RUN curl -fsSL "https://github.com/typst/typst/releases/download/v$TYPST_VERSION/typst-$(uname -m)-unknown-linux-musl.tar.xz" \
    | tar -xJ --strip-components=1

ADD --keep-git-dir=false "$ALGOTYPST_REPO#$ALGOTYPST_REF" src

RUN sh src/docker/fetch-fonts.sh fonts
RUN sh src/docker/fetch-logo.sh src/assets \
    && HOME=/work/home python3 src/install.py

FROM mcr.microsoft.com/devcontainers/base:2-trixie

COPY --from=build /work/typst /usr/local/bin/typst
COPY --from=build /work/fonts /usr/local/share/fonts/algotypst

USER vscode
RUN mkdir -p /home/vscode/.local/share/typst/packages
COPY --chown=vscode:vscode --from=build /work/home/.local/share/typst/packages /home/vscode/.local/share/typst/packages
