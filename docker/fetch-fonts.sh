#!/bin/sh
# Usage: ./fetch-fonts.sh <outdir>
# Places all fonts in outdir
set -eu

CTAN_MIRROR="${CTAN_MIRROR:-https://mirrors.ctan.org}"
FONT_AWESOME_VERSION="${FONT_AWESOME_VERSION:-7.0.0}"

out="$1"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$out"

# Same selection as the download-fonts script in flake.nix.
curl -fsSL -o "$tmp/roboto.zip" "$CTAN_MIRROR/fonts/roboto.zip"
unzip -q -j "$tmp/roboto.zip" 'roboto/opentype/*.otf' -d "$out/roboto" -x '*/RobotoCondensed*' '*/RobotoSerif*'
curl -fsSL -o "$tmp/xcharter.zip" "$CTAN_MIRROR/fonts/xcharter.zip"
unzip -q -j "$tmp/xcharter.zip" 'xcharter/opentype/*.otf' -d "$out/xcharter"

# Required by @preview/fontawesome.
curl -fsSL -o "$tmp/fontawesome.zip" "https://github.com/FortAwesome/Font-Awesome/releases/download/$FONT_AWESOME_VERSION/fontawesome-free-$FONT_AWESOME_VERSION-desktop.zip"
unzip -q -j "$tmp/fontawesome.zip" '*/otfs/*.otf' -d "$out/fontawesome"
