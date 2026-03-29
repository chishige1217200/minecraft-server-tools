#!/bin/bash

set -euo pipefail

# Check for required tools
if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is required but not installed." >&2
  exit 1
fi

if ! command -v wget >/dev/null 2>&1; then
  echo "Error: wget is required but not installed." >&2
  exit 1
fi

# Validate input
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <version>" >&2
  exit 1
fi
VERSION="$1"

# Path to JSON file containing versions
VJSON="versions.json"
if [[ ! -f "$VJSON" ]]; then
  echo "Error: $VJSON not found." >&2
  exit 1
fi

# Retrieve download URL for the requested version
URL=$(jq -r --arg v "$VERSION" '.[$v].url' "$VJSON")
if [[ "$URL" == "null" || -z "$URL" ]]; then
  echo "Error: Version $VERSION not found in $VJSON." >&2
  exit 1
fi

# Download server.jar
echo "Downloading Minecraft server version $VERSION from $URL ..."
wget -O minecraft_server.$VERSION.jar "$URL"
echo "Download complete. server.jar saved."
