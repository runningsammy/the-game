# Agent Journal

**PURPOSE:** Quick context for AI agents. Information-dense project state.  
**FOR AGENTS:** Read this first. Contains critical rules and current state.  
**FOR USERS:** See README.md instead.

---

## Current State (Dec 2024)

**Project:** 2D pixel art game, vanilla JS, HTML5 Canvas  
**Architecture:** Single-file (game.html), ~2000 lines  
**User:** Novice programmer learning game dev + Linux

## Structure

```
assets/sprites/  - PNG sprites (player, NPCs, items)
assets/piskel/   - Sprite source files
docs/           - README.md (user docs), JOURNAL.md (this)
scripts/        - Permanent bash scripts only
tmp/            - Temporary files (gitignored)
game.html       - Main game file
server.js       - Optional Node.js server
.cursorrules    - AI behavior rules (READ THIS)
```

## Technical

- **Game loop:** 60fps, requestAnimationFrame
- **World:** 2400x2000px, camera lerp 0.12
- **Canvas:** 800x500px internal, scales to viewport
- **Collision:** AABB, circle-based for NPCs
- **Assets:** `assets/sprites/` (paths updated from root)
- **Known 404:** iron-shovel.png (not created yet)

## Features

- Movement: WASD/arrows, sprint (Shift), stamina
- NPCs: Shopkeeper (shop system), Old Guy (dialogue)
- Minigames: Pot balancing, Brushing (50/50 chance)
- Shop: 5 shovel tiers, affects minigame rewards
- Inventory: E key, 15 slots + 1 equipment
- Money: Earn from minigames, display with border sprite

## Recent Work

- Reorganized files: sprites→assets/sprites/, scripts→scripts/, docs→docs/
- Converted Windows scripts to bash (.sh)
- Created tmp/ for temporary files (gitignored)
- Updated all sprite paths in game.html
- Verified working: Python server + Playwright test
- Created .cursorrules with AI behavior guidelines

## Tools

**Installed:** ImageMagick, pngquant, sharp-cli, http-server, browser-sync, Git Bash  
**Pending:** wget, tree, jq, ripgrep, fd, bat, ncdu, fzf, tldr (script in tmp/)

## AI Guidelines

**Recommended:**
- Add educational comments explaining WHY
- Ask leading questions before implementing
- Verify work (check output, test results)
- Use existing files for documentation

**Avoid:**
- Temporary doc files (use tmp/ folder instead)
- Windows-only scripts in scripts/ (prefer bash)
- Advanced patterns without explanation
- Over-engineering (keep it simple)

**File Organization:**
- Permanent → scripts/, docs/, assets/
- Temporary → tmp/ (gitignored)

## User Context

**Learning Goals:** Game dev, Linux CLI, file organization, Git  
**Teaching Style:** Questions + trade-offs, explain concepts, novice-appropriate  
**Communication:** Direct responses, not files

**Rationale for Approach:**
- User is building foundational skills - habits formed now persist
- Questions teach decision-making, not just solutions
- Verification teaches debugging and attention to detail
- Clean file organization prevents future technical debt
- Educational comments make code a learning resource

## Server

Start: `./scripts/start-server.sh` (auto-detects Python/Node/http-server)  
Open: `./scripts/open-game.sh` (checks if running first)  
Verified: Works on localhost:8080, all sprites load correctly

---

*Last Updated: Dec 24, 2024*
