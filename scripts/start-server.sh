#!/bin/bash

# Simple HTTP Server for the game
# Navigate to project root
cd "$(dirname "$0")/.." || exit 1

PORT=8080
URL="http://localhost:$PORT"

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
    echo "Please open $url in your browser"
  fi
}

echo "================================"
echo "Starting Game Server"
echo "================================"

# Check if port is already in use
if lsof -Pi :$PORT -sTCP:LISTEN -t >/dev/null 2>&1 ; then
  echo "⚠️  Port $PORT is already in use"
  echo "Opening browser to existing server..."

  open_browser "${URL}/game.html"
  exit 0
fi

echo "📂 Project: $(pwd)"
echo "🌐 Server: $URL"
echo "🎮 Game: ${URL}/game.html"
echo ""
echo "Press Ctrl+C to stop the server"
echo "================================"
echo ""

# Try different server options in order of preference
if command -v python3 > /dev/null; then
  # Open browser after a short delay
  (sleep 2 && open_browser "${URL}/game.html") &

  echo "Using Python 3 HTTP server..."
  python3 -m http.server $PORT

elif command -v python > /dev/null; then
  # Open browser after a short delay
  (sleep 2 && open_browser "${URL}/game.html") &

  echo "Using Python HTTP server..."
  python -m http.server $PORT

elif command -v http-server > /dev/null; then
  echo "Using http-server (npm)..."
  http-server -p $PORT -o /game.html

elif command -v node > /dev/null && [ -f "server.js" ]; then
  # Open browser after a short delay
  (sleep 2 && open_browser "${URL}/game.html") &

  echo "Using Node.js server..."
  node server.js

else
    echo "❌ Error: No suitable HTTP server found!"
    echo ""
    echo "Please install one of the following:"
    echo "  - Python 3: python3 -m http.server"
    echo "  - Python 2: python -m SimpleHTTPServer"
    echo "  - Node.js: npm install -g http-server"
    echo ""
    exit 1
fi

