#!/bin/bash
# Build the Windows .exe and keep the runnable folder in sync with code.
# This script is intentionally verbose so it is easy to learn from.

set -e

# --- Paths --------------------------------------------------------------
# Project root is one level up from this script
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

# Electron-builder output folder (built from current code)
DIST_DIR="$PROJECT_ROOT/dist/win-unpacked"

# Easy-to-run folder (keeps the latest .exe + DLLs)
TARGET_DIR="/c/Users/PotentialError/projects/Game"

# Optional shareable zip for download/testing
ZIP_PATH="/c/Users/PotentialError/Downloads/Dig_dig_dig_game_win.zip"

echo "================================"
echo "Build + Sync Windows .exe"
echo "================================"
echo "Project: $PROJECT_ROOT"
echo "Build output: $DIST_DIR"
echo "Sync folder: $TARGET_DIR"
echo "Zip output: $ZIP_PATH"
echo ""

cd "$PROJECT_ROOT"

# --- Build --------------------------------------------------------------
# Electron tries to auto-discover a code-signing identity.
# We disable that so the build works on a learning machine.
export CSC_IDENTITY_AUTO_DISCOVERY=false

echo "Building Windows app..."
npm run build
echo ""

# --- Sync exe folder ----------------------------------------------------
if [ ! -d "$DIST_DIR" ]; then
  echo "❌ Build output not found: $DIST_DIR"
  echo "Make sure the build finished without errors."
  exit 1
fi

echo "Syncing build output to easy-run folder..."
rm -rf "$TARGET_DIR"
mkdir -p "$TARGET_DIR"
cp -R "$DIST_DIR/"* "$TARGET_DIR/"

# Rename the exe to the friendly name we share with others
if [ -f "$TARGET_DIR/Dig_dig_dig_Prototype.exe" ]; then
  mv "$TARGET_DIR/Dig_dig_dig_Prototype.exe" \
    "$TARGET_DIR/Dig_dig_dig_game.exe"
fi

# --- Optional zip -------------------------------------------------------
# Set SKIP_ZIP=true to skip zipping if you only need the .exe folder.
if [ "$SKIP_ZIP" != "true" ]; then
  if command -v cygpath > /dev/null; then
    DIST_DIR_WIN="$(cygpath -w "$DIST_DIR")"
    ZIP_PATH_WIN="$(cygpath -w "$ZIP_PATH")"

    echo "Creating zip..."
    powershell.exe -NoProfile -Command \
      "Compress-Archive -Path '${DIST_DIR_WIN}\\*' \
      -DestinationPath '${ZIP_PATH_WIN}' -Force"
  else
    echo "⚠️  cygpath not found, skipping zip step."
    echo "    Run the zip command manually in PowerShell if needed."
  fi
fi

echo ""
echo "✅ Build synced! Run this again after code changes."
