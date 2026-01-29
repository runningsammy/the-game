#!/bin/bash
# Fast sync script: updates an already-built Electron folder with new game code.
# Use this when electron-builder can't run (e.g., symlink permissions on Windows).

set -e

PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
EXE_DIR="/c/Users/PotentialError/projects/Game"

echo "================================"
echo "Sync Existing .exe Folder"
echo "================================"
echo "Project: $PROJECT_ROOT"
echo "Target : $EXE_DIR"
echo ""

if [ ! -d "$EXE_DIR" ]; then
  echo "❌ Existing exe folder not found:"
  echo "   $EXE_DIR"
  echo "Make sure you already have a working build copied there."
  exit 1
fi

cd "$PROJECT_ROOT"

echo "Copying updated game files into exe folder..."

# Core game files
cp game.html "$EXE_DIR/"
cp main.js "$EXE_DIR/" 2>/dev/null || true
cp preload.js "$EXE_DIR/" 2>/dev/null || true

# Assets (replace the whole assets folder to keep things simple)
rm -rf "$EXE_DIR/assets"
cp -R assets "$EXE_DIR/"

echo ""
echo "✅ Sync complete."
echo "Run the game from:"
echo "  C:\\Users\\PotentialError\\projects\\Game\\Dig_dig_dig_game.exe"

