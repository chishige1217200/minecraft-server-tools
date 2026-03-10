#!/bin/bash

set -e

BACKUP_ROOT="/backup/minecraft"
LATEST="$BACKUP_ROOT/latest"
TMP="/tmp/minecraft-backup"
NAS="/mnt/nas/minecraft"

DATE=$(date +%F)
ARCHIVE="minecraft-$DATE.tar.zst"

mkdir -p "$TMP"
mkdir -p "$NAS"

echo "Creating archive..."

tar \
  --use-compress-program="zstd -10 -T0" \
  -cf "$TMP/$ARCHIVE" \
  -C "$LATEST" .

echo "Copying to NAS..."

mv "$TMP/$ARCHIVE" "$NAS/"

echo "Backup complete"