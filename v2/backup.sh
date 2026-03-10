#!/bin/bash

set -e

SRC="/opt/minecraft/"
DEST="/backup/minecraft"

TODAY=$(date +%F)
LATEST=$(readlink -f "$DEST/latest" || true)

mkdir -p "$DEST/$TODAY"

if [ -d "$LATEST" ]; then
    rsync -a --delete \
      --link-dest="$LATEST" \
      "$SRC" "$DEST/$TODAY"
else
    rsync -a "$SRC" "$DEST/$TODAY"
fi

rm -f "$DEST/latest"
ln -s "$DEST/$TODAY" "$DEST/latest"