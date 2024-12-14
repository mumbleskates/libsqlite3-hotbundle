#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
echo "$SCRIPT_DIR"
cd "$SCRIPT_DIR" || { echo "fatal error" >&2; exit 1; }
SQLITE3_LIB_DIR="$SCRIPT_DIR/sqlite3"

if [[ -z "$1" ]]
then
  echo "USAGE: ./upgrade.sh VERSION"
  echo "...where VERSION is the 7-digit sqlite version, like 3470200"
  exit 2
fi

SQLITE_VERSION="$1"

# Download and extract amalgamation
curl -O "https://sqlite.org/$(date +%Y)/sqlite-amalgamation-${VERSION}.zip"
unzip -p "$SQLITE.zip" "$SQLITE/sqlite3.c" > "$SQLITE3_LIB_DIR/sqlite3.c"
unzip -p "$SQLITE.zip" "$SQLITE/sqlite3.h" > "$SQLITE3_LIB_DIR/sqlite3.h"
unzip -p "$SQLITE.zip" "$SQLITE/sqlite3ext.h" > "$SQLITE3_LIB_DIR/sqlite3ext.h"
rm -f "$SQLITE.zip"
