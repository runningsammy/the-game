# Game Development Journal

## How to Start the Server

The game can be run in two ways:

### Method 1: Direct File Opening (No Server Needed)
- Simply double-click `game.html` in Windows Explorer
- The game will open in your default browser
- **Note**: This works because the game has been designed to work standalone without a server

### Method 2: Using a Local Server (Recommended for Development)
If you need to test with a server (for example, if PNG assets aren't loading), you can use:

**PowerShell HTTP Server:**
```powershell
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add('http://localhost:8080/')
$listener.Start()
Write-Host 'Server running at http://localhost:8080/'
while($listener.IsListening) {
  $context = $listener.GetContext()
  $request = $context.Request
  $response = $context.Response
  $file = if($request.Url.LocalPath -eq '/') { 'game.html' } else { $request.Url.LocalPath.TrimStart('/') }
  $filePath = Join-Path $PWD $file
  if(Test-Path $filePath) {
    $content = [System.IO.File]::ReadAllBytes($filePath)
    $response.ContentType = if($file -match '\.html$') { 'text/html' } elseif($file -match '\.png$') { 'image/png' } else { 'text/plain' }
    $response.ContentLength64 = $content.Length
    $response.OutputStream.Write($content, 0, $content.Length)
  } else {
    $response.StatusCode = 404
  }
  $response.Close()
}
```

**Alternative: Node.js Server (if available):**
```bash
node server.js
```

**Alternative: Python Server (if available):**
```bash
python -m http.server 8080
```

Then navigate to: `http://localhost:8080/` or `http://localhost:8080/game.html`

---

## Game Overview

**Title:** Simple Player Movement

**Type:** 2D top-down pixel art game

### Core Mechanics

1. **Player Movement**
   - Move with WASD or Arrow Keys
   - Hold Shift to sprint (uses stamina)
   - Stamina system: drains while sprinting, regenerates when not
   - Player can become exhausted if stamina reaches 0
   - Player sprite changes based on movement:
     - Idle sprite when stationary
     - Walking animation (alternates between 2 frames) when moving
     - Back-facing sprite when moving upward
     - Walking animation is 75% slower when walking, 125% faster when sprinting
   - Small black arrow triangle shows movement direction (doesn't overlap player)

2. **World**
   - World size: 2400x2000 pixels
   - Canvas size: 800x500 pixels (internal resolution)
   - Camera follows player smoothly
   - Procedurally generated tile-based world with:
     - Grass tiles (most common)
     - Rock tiles (single and clusters)
     - Mounded bushes
     - Log rows
     - Red X tiles (special - trigger minigame)
   - 65 trees scattered throughout
   - Grid overlay for visual reference

3. **Shop System**
   - Shopkeeper NPC (yellow circle) located at world.width - 100, world.height - 100
   - Press Q near shopkeeper to interact
   - Dialogue system: "Hello" → "What would you like?" → Shop menu
   - Shop items:
     - Simple shovel (Tier 1) - $25
     - Iron Shovel (Tier 2) - $200
     - Steel Shovel (Tier 3) - $150
     - Diamond Shovel (Tier 4) - $500
     - Legendary Shovel (Tier 5) - $2000
   - Items show "SOLD" if already purchased
   - Press 1-5 to buy items, Q to close

4. **Inventory System**
   - Press E to open/close inventory
   - 15 inventory slots (currently empty)
   - 1 equipment slot (for shovels)
   - Equipment affects minigame rewards

5. **Balancing Minigame**
   - Stand on red X tiles and press Q to start
   - Balance a pot on a stick for 15 seconds
   - Use arrow keys to keep the pot from tipping!
   - Success: 3x base reward (with shovel multipliers)
   - Failure: Base reward only (with shovel multipliers)
   - Shovel multipliers:
     - Tier 1: 1.5x (success: 4.5x)
     - Tier 2: 2.0x (success: 6.0x)
   - Red X tile converts to grass after completion
   - All text in minigame is white

6. **Money System**
   - Starts at $0
   - Earned from balancing minigame
   - Displayed in top-right corner with decorative border sprite
   - Border is centered on the money text

### Assets

**Required PNG Files (in same directory as game.html):**
- `player.png` - Player idle sprite (39x39 pixels, front-facing)
- `player_back.png` - Player idle sprite when facing backward
- `player_walk1.png` - Player walking animation frame 1 (front-facing)
- `player_walk2.png` - Player walking animation frame 2 (front-facing)
- `player_back_walk1.png` - Player walking animation frame 1 (back-facing)
- `player_back_walk2.png` - Player walking animation frame 2 (back-facing)
- `pot.png` - Pot sprite for balancing minigame
- `money_border.png` - Decorative border sprite for money counter
- `shovel.png` - Simple shovel sprite (Tier 1)
- `iron-shovel.png` - Iron shovel sprite (Tier 2)

**Note:** The game has fallback rendering if PNGs don't load, but the user specifically requested using their PNG assets, not remakes.

### Technical Details

- **Rendering:** Canvas 2D API with pixelated rendering
- **Camera:** Smooth follow with lerp (0.12), rounded to prevent jitter
- **Collision:** Circle-based collision detection for trees and shopkeeper
- **Performance:** Game runs at 60fps using requestAnimationFrame
- **No external dependencies:** Pure HTML/CSS/JavaScript

### Key Features Implemented

- ✅ Player movement with momentum and friction
- ✅ Stamina system with exhaustion mechanics
- ✅ Procedural world generation
- ✅ Shop system with dialogue
- ✅ Inventory system
- ✅ Balancing minigame
- ✅ Money system
- ✅ Equipment system (shovels)
- ✅ Camera shake fix (camera position rounded)
- ✅ SOLD indicator for purchased items
- ✅ Responsive canvas sizing (fills browser window)
- ✅ Player sprite system with idle, walking, and back-facing animations
- ✅ Direction indicator (black arrow triangle)
- ✅ Money border sprite
- ✅ All text is white
- ✅ Stamina label removed (bar remains)

### Important Notes for Next Agent

1. **No Server Required:** The game is designed to work by double-clicking game.html directly. The user specifically requested this because servers lag their computer and make Google think they're a bot.

2. **PNG Assets:** The user has their own PNG files and wants to use them, not remakes. Always check if PNGs exist before creating fallbacks.

3. **Performance:** Previous optimizations were reverted because the user felt the game ran better before. Be cautious about "optimizations" that might actually make things worse.

4. **Camera:** Camera position is rounded to prevent screen shake. This was a specific fix requested by the user.

5. **Canvas Sizing:** The canvas is set to fill the browser window vertically while maintaining aspect ratio. Internal resolution is 800x500, but it scales to fit the viewport.

6. **Code Style:** The game uses vanilla JavaScript in an IIFE (Immediately Invoked Function Expression). No frameworks or build tools.

---

## File Structure

```
c:\Users\PotentialError\
├── game.html              # Main game file (all code in one file)
├── player.png             # Player idle sprite (front-facing)
├── player_back.png        # Player idle sprite (back-facing)
├── player_walk1.png       # Player walking animation frame 1 (front)
├── player_walk2.png       # Player walking animation frame 2 (front)
├── player_back_walk1.png  # Player walking animation frame 1 (back)
├── player_back_walk2.png  # Player walking animation frame 2 (back)
├── pot.png                # Pot sprite for minigame
├── money_border.png       # Decorative border for money counter
├── shovel.png             # Simple shovel sprite
├── iron-shovel.png        # Iron shovel sprite
├── server.js              # Node.js server (optional)
├── start-server.bat       # Batch file to start server
├── start-server.ps1       # PowerShell script to start server
├── open-game.bat          # Batch file to open game
└── README-SERVER.md       # Server documentation
```

---

## Controls Summary

- **WASD / Arrow Keys:** Move player
- **Shift:** Sprint (drains stamina)
- **E:** Open/close inventory
- **Q:** Interact (shopkeeper, red X tiles)
- **1-5:** Buy items in shop (when shop is open)

---

---

## Recent Changes (December 2024)

### Player Sprite System
- **Player Size**: Increased from 28x28 to 39x39 pixels (40% larger)
- **Sprite System**: Implemented directional sprite system:
  - Idle sprite (`player.png`) when stationary
  - Walking animation when moving (alternates between 2 frames)
  - Back-facing sprite when moving upward
  - Walking animation speed: 75% slower when walking, 125% faster when sprinting
- **Direction Indicator**: Replaced line indicator with small black arrow triangle that shows movement direction without overlapping player

### UI Improvements
- **Text Colors**: All text in the game is now white
- **Stamina Bar**: Removed the "Stamina" / "Stamina (Exhausted)" label (bar remains visible)
- **Money Display**: Added decorative border sprite (`money_border.png`) that is centered on the money text
- **Minigame Text**: Updated instruction text to "Use arrow keys to keep the pot from tipping!" and reduced font size to fit properly

### Assets Added
- `player_back.png` - Back-facing idle sprite
- `player_walk1.png` / `player_walk2.png` - Front-facing walking animation frames
- `player_back_walk1.png` / `player_back_walk2.png` - Back-facing walking animation frames
- `money_border.png` - Decorative border for money counter

*Last Updated: December 2024*



