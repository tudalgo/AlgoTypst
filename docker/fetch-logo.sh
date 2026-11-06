#!/bin/sh
# Usage: ./fetch-logo.sh <outdir>
# Places logo as tuda_logo.svg in outdir
set -eu

PDF_URL="${PDF_URL:-https://www.intern.tu-darmstadt.de/media/medien_stabsstelle_km/services/medien_cd/das_bild_der_tu_darmstadt.pdf}"

out="$1"
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$out"

# Logo is run of paths starting from (x=416.6016, y=301.9883, 155.9058 x 62.3633 pt) 
# up to next 0.6 wide rule.
# grep fails if handbook's layout changes.
curl -fsSL -o "$tmp/handbook.pdf" "$PDF_URL"
pdf2svg "$tmp/handbook.pdf" "$tmp/page.svg" 1
{
    echo '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="155.9058pt" height="62.3633pt" viewBox="416.6016 301.9883 155.9058 62.3633">'
    sed -n '/d="M 416\.601562 301\.988281 /,/stroke-width="0\.6"/{/stroke-width="0\.6"/!p}' "$tmp/page.svg"
    echo '</svg>'
} > "$out/tuda_logo.svg"
grep -q 'M 416\.601562 301\.988281 ' "$out/tuda_logo.svg"
