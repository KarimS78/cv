#!/bin/sh
# Builds the PDF (and the README preview) from index.html with headless Chrome.
#   ./build.sh           full PDF, with private.js if present
#   ./build.sh public    public PDF + preview.png, private details left out
set -e
cd "$(dirname "$0")"
CHROME="${CHROME:-/Applications/Google Chrome.app/Contents/MacOS/Google Chrome}"
URL="file://$PWD/index.html"
OUT="CV_Karim_Sehil_EN.pdf"
if [ "$1" = "public" ]; then
  URL="$URL?public"
  OUT="CV_Karim_Sehil_EN_public.pdf"
  "$CHROME" --headless=new --disable-gpu --hide-scrollbars --force-device-scale-factor=2 \
    --window-size=850,1179 --virtual-time-budget=6000 --screenshot=preview.png "$URL" >/dev/null 2>&1
  echo "preview.png"
fi
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer --virtual-time-budget=6000 \
  --print-to-pdf="$OUT" "$URL" >/dev/null 2>&1
echo "$OUT"
