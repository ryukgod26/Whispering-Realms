# Whispering Realms

<a id="readme-top"></a>

<div align="center">
    <h3 align="center">🏰 Whispering Realms 🏰</h3>
    <p align="center">
        An immersive 3D action-adventure game built with Godot Engine
        <br />
        Explore dungeons, defeat bosses, and uncover the mysteries of the realm
        <br />
        <br />
        <a href="#features">View Features</a>
        ·
        <a href="#project-structure">Project Structure</a>
        ·
        <a href="#getting-started">Getting Started</a>
    </p>
</div>

<details>
    <summary>Table of Contents</summary>
    <ol>
        <li><a href="#about">About The Project</a></li>
        <li><a href="#features">Features</a></li>
        <li><a href="#project-structure">Project Structure</a></li>
        <li><a href="#getting-started">Getting Started</a></li>
        <li><a href="#gameplay">Gameplay</a></li>
        <li><a href="#license">License</a></li>
    </ol>
</details>

---

## About

**Whispering Realms** is a fantasy 3D action-adventure game developed in Godot 4.5. Players embark on an epic journey through mystical dungeons and vast landscapes, encountering formidable enemies and legendary bosses. The game combines exploration, combat, magic, and puzzle-solving for an immersive experience.

---

## Features

✨ **Core Gameplay**
- 🗺️ Expansive overworld with multiple environments
- 🏰 Dungeon exploration with dynamic environments
- ⚔️ Real-time combat system with various enemies
- 👹 Epic boss encounters including dragon and skeleton warriors
- 🎭 Multiple character skins and customization

🎮 **Combat & Magic**
- Melee sword combat
- Fireball spell system
- Healing magic
- Enemy AI with different behaviors

🎨 **Visual Features**
- 3D terrain with Terrain3D plugin
- Dynamic lighting and effects
- Particle effects for spells and movement
- Environmental objects and props

🎵 **Audio**
- Background music system
- Sound effects integration

📱 **UI/UX**
- Main menu
- Pause menu
- Options menu
- Loading screens
- Health/UI system
- Inventory (in development)

---

## Project Structure

```
whispering-realms/
├── assets/              # Game assets (audio, models, textures)
│   ├── audio/          # Background music and SFX
│   ├── boss/           # Boss-related assets
│   ├── characters/     # Character models
│   ├── Enemy/          # Enemy assets
│   ├── weapons/        # Weapon models
│   ├── environment/    # Environmental assets
│   └── ui/             # UI elements
├── scenes/             # Godot scene files
│   ├── player.tscn     # Player character
│   ├── level.tscn      # Main gameplay level
│   ├── dungeon.tscn    # Dungeon scenes
│   ├── boss_dungeon_scene.tscn # Boss arena
│   ├── over_world.tscn # Overworld map
│   ├── main_menu.tscn  # Main menu
│   ├── pause_menu.tscn # Pause menu
│   └── ...
├── scripts/            # GDScript files
│   ├── player.gd       # Player controller
│   ├── enemy.gd        # Enemy AI
│   ├── boss.gd         # Boss behavior
│   ├── level.gd        # Level management
│   ├── Menus/          # Menu scripts
│   └── ...
├── shaders/            # Custom shaders
├── addons/             # Godot plugins
│   ├── godot_super-wakatime/
│   ├── proton_scatter/
│   └── terrain_3d/
├── Mesh_Library/       # Mesh resources
├── Terrain_3d_resource_files/  # Terrain data
└── project.godot       # Project configuration
```

## Getting Started

### Prerequisites
- **Godot Engine 4.5** or later
- Git

### Installation

1. **Clone the repository**
   ```sh
   git clone https://github.com/ryukgod26/Whispering-Realms.git
   cd Whispering-Realms
   ```

2. **Open in Godot**
   - Launch Godot Engine
   - Select "Import" and navigate to the project folder
   - Open `project.godot`

3. **Run the game**
   - Press `F5` or click the Play button in the editor
   - The game will start from the main menu

### Controls

| Action | Key |
|--------|-----|
| Move Forward | W / Up Arrow |
| Move Backward | S / Down Arrow |
| Move Left/Right | A / D |
| Run | Shift |
| Jump | Space |
| Attack | Left Click |
| Cast Spell | Right Click |
| Pause | ESC |

---

## Gameplay

### Main Features

**Exploration**
- Navigate through interconnected dungeons and overworld
- Discover hidden areas and secrets
- Interact with environmental objects

**Combat**
- Engage in real-time melee combat
- Face diverse enemies with unique behaviors
- Utilize spells and special abilities

**Boss Battles**
- Epic encounters with legendary bosses
- Dragon Boss - aerial combat challenge
- Skeleton Mage & Skeleton Warriors - tactical battles

**Progression**
- Collect health pickups (hearts)
- Defeat enemies to progress
- Unlock new areas as you advance
