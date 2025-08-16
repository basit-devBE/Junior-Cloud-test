#!/bin/bash
read -p "Enter the path of the folder you want backed up :"  SRC


DEST="./.backups"

mkdir -p "$DEST"

TS=$(date +%F-%H-%M)
ZIP_NAME="$DEST/backup-$TS.zip"

if [ ! -d "$SRC" ]; then
  echo "Source directory does not exist."
  exit 1
fi


if zip -r "$ZIP_NAME" "$SRC" -x "*/$DEST/*" "*/.git/*"; then
  echo "Backup successful: $ZIP_NAME"
else
  echo "Error: Failed to create backup."
  exit 1
fi