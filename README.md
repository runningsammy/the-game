# The Game

A 2D pixel art adventure game with player movement, NPCs, minigames, and a shop system.

## 📁 Project Structure

```
the-game/
├── assets/
│   ├── sprites/          # All PNG sprite files
│   └── piskel/           # Piskel project files
├── docs/                 # Documentation and journals
├── scripts/              # Bash scripts
├── game.html             # Main game file
├── index.html            # Entry point (redirects to game.html)
├── server.js             # Node.js server
├── .cursorrules          # Coding guidelines for AI
└── the-game.code-workspace  # VS Code workspace configuration
```

## 🎮 How to Play

### Option 1: Using the Start Script (Recommended)
```bash
./scripts/start-server.sh
```
This will automatically:
- Find an available HTTP server (Python, Node.js, or http-server)
- Start the server on port 8080
- Open your browser to the game

### Option 2: Direct File
Simply open `game.html` in your browser (some features may not work).

### Option 3: Node.js Server
```bash
node server.js
```

### Option 4: Live Server
If you have VS Code/Cursor with Live Server extension:
1. Open the workspace file: `the-game.code-workspace`
2. Right-click on `game.html` → "Open with Live Server"

## 🎯 Game Features

- **Player Movement**: WASD or Arrow keys
- **NPCs**: Interact with characters (E key)
- **Minigames**: 
  - Pot Planting (with Old Guy)
  - Digging (with Shopkeeper)
- **Shop System**: Buy upgrades and items
- **Smooth Camera**: Follows player with lerp interpolation
- **Pixel Art**: All sprites rendered with crisp pixel art style

## 🛠️ Development

See `docs/` folder for:
- `README.md` - Detailed game documentation and technical details
- `JOURNAL.md` - Development journal

## 🚀 Quick Start

```bash
# Start the game (auto-opens browser)
./scripts/start-server.sh

# Or with Node.js
node server.js

# Then open browser manually
./scripts/open-game.sh
```

## 📝 License

This is a personal project.

