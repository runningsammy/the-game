# The Game

A 2D top-down pixel art game built with HTML5 Canvas and vanilla JavaScript. Features player movement, NPCs, minigames, a shop system, and an inventory.

## Features

### Core Mechanics
- **Player Movement**: Move with WASD or Arrow Keys, sprint with Shift
- **Stamina System**: Sprint drains stamina, regenerates when not sprinting
- **Procedural World**: 2400x2000 pixel world with procedurally generated tiles
- **Camera System**: Smooth camera follow with pixel-perfect rendering

### NPCs & Interactions
- **Shopkeeper**: Buy shovels and equipment at the shop
- **Old Guy**: Friendly NPC who greets you
- **Dialogue System**: Press Q to interact with NPCs and progress dialogue

### Minigames
- **Balancing Minigame** (50% chance): Balance a pot on a stick for 15 seconds using arrow keys
- **Brushing Minigame** (50% chance): Hold SPACE to brush dirt clean, release before it turns red (5-10 seconds)

### Shop & Inventory
- **Shop System**: Purchase shovels of different tiers (Tier 1-5)
- **Inventory**: Press E to open/close inventory
- **Equipment**: Equipped shovels affect minigame rewards

### Money System
- Earn money by completing minigames
- Money displayed in top-right corner with decorative border
- Shovel multipliers increase rewards:
  - Tier 1: 1.5x (success: 4.5x)
  - Tier 2: 2.0x (success: 6.0x)

## How to Play

### Starting the Game
Use the start script (recommended):
```bash
./scripts/start-server.sh
```

Alternatively:
- **Direct**: Open `game.html` in your browser (some features may not work)
- **Node.js**: `node server.js`
- **Python**: `python -m http.server 8080`

### Controls
- **WASD / Arrow Keys**: Move player
- **Shift**: Sprint (drains stamina)
- **E**: Open/close inventory
- **Q**: Interact (NPCs, red X tiles for minigames)
- **1-5**: Buy items in shop (when shop is open)
- **SPACE**: Used in brushing minigame

### Gameplay Tips
1. Find red X tiles on the ground and press Q to start a minigame
2. Complete minigames to earn money
3. Visit the shopkeeper (yellow sprite) to buy better shovels
4. Better shovels = better rewards from minigames
5. Talk to NPCs by getting close and pressing Q

## Technical Details

- **Rendering**: Canvas 2D API with pixelated rendering
- **Camera**: Smooth follow with lerp (0.12), rounded to prevent jitter
- **Collision**: Circle-based collision detection
- **Performance**: 60fps using requestAnimationFrame
- **No Dependencies**: Pure HTML/CSS/JavaScript

## File Structure

```
the-game/
├── assets/
│   ├── sprites/           # All PNG sprite files
│   │   ├── player*.png    # Player sprites (idle, walk, back)
│   │   ├── pot.png        # Balancing minigame
│   │   ├── brush.png      # Brushing minigame
│   │   ├── dirt.png       # Brushing minigame
│   │   ├── money_border.png
│   │   ├── shopkeeper.png
│   │   ├── oldguy.png
│   │   └── shovel.png     # Tier 1 shovel
│   └── piskel/            # Source files for sprites
├── docs/
│   ├── README.md          # This file - detailed documentation
│   └── JOURNAL.md         # Development journal
├── scripts/
│   ├── start-server.sh    # Start game server
│   └── open-game.sh       # Open game in browser
├── game.html              # Main game file (all code in one file)
├── index.html             # Entry point
├── server.js              # Node.js server (optional)
├── .cursorrules           # Coding guidelines
└── the-game.code-workspace # VS Code workspace config
```

## Development

This game was built as a standalone HTML file with no build process required. All game logic, rendering, and assets are self-contained.

### Key Features Implemented
- ✅ Player movement with momentum and friction
- ✅ Stamina system with exhaustion mechanics
- ✅ Procedural world generation
- ✅ Shop system with dialogue
- ✅ Inventory system
- ✅ Two different minigames (balancing and brushing)
- ✅ Money system
- ✅ Equipment system (shovels)
- ✅ NPCs with dialogue
- ✅ Tutorial system

## License

This project is open source and available for use.

## Credits

Built with vanilla JavaScript, HTML5 Canvas, and pixel art sprites.

