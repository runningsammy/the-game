#!/bin/bash

# Open the game in browser
# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

URL="http://localhost:8080/game.html"

# --- Browser Helper -----------------------------------------------------
# Use the right opener for the current OS/shell.
# On Windows Git Bash, `cmd.exe /c start` is the reliable option.
open_browser() {
  local url="$1"

  if command -v xdg-open > /dev/null; then
    xdg-open "$url"
  elif command -v open > /dev/null; then
    open "$url"
  elif command -v cmd.exe > /dev/null; then
    cmd.exe /c start "" "$url" > /dev/null 2>&1
  else
    echo "❌ Could not detect browser opener"
    echo "Please open this URL manually: $url"
  fi
}

echo "================================"
echo "Opening Game in Browser"
echo "================================"
echo "URL: $URL"
echo ""

# Check if server is running
if ! curl -s "$URL" > /dev/null 2>&1; then
    echo "⚠️  Server doesn't appear to be running on port 8080"
    echo ""
    echo "Please start the server first:"
    echo "  ./scripts/start-server.sh"
    echo "  OR"
    echo "  node server.js"
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

echo "✓ Server is running"
echo "Opening browser..."

open_browser "$URL"

echo ""
echo "Done!"

