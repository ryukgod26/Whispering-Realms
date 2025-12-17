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
        <li><a href="#gameplay">Gameplay</a></li>
    </ol>
</details>

---

## About

This is my First 3D Game. I have Learned a lot (by lot I mean really lot) of things about godot and 3D Game Development by making this Game. Since This is my First 3D Game I have Used a lot of free (almost all) assets availaible on Internet to make this Game. I learned a lot of new things. All the features in this Game Which I have Created like Loading Screen, Using Animation Player, Good Pause Menu etc. are the features I have Implemented First Time in any Game. I have also added lot of features in the options or setings menu. Currently This Game does not have any Specifc Stortyline or Anything because I only created this game to learn about how to create a 3D game in Godot and I also did not knew how to create and animate Models in Blender (Which I have been learning now). So In the Future I will be adding new characters and a storyline to the game. I will also Recreate many Characters Like the Player and will give It a cool look in the future. I also have Plan to add a Dragon Boss But the model I found had mixed up animations SO I will take that for next Update.

---

## Features

**Core Gameplay**
- Expansive overworld with multiple environments
-  Dungeon exploration with dynamic environments
-  Real-time combat system with various enemies
- Simple Boss Encounter For now

 **Combat & Magic**
- Melee sword combat
- Fireball spell system
- Healing magic
- Enemy AI with many attack like fireball

 **Visual Features**
- 3D terrain with Terrain3D plugin
- Dynamic lighting and effects
- Particle effects for spells and movement
- Environmental objects and props
- Grass with Proton Scatter

 **Audio**
- Background music system
- Sound effects integration
- Water Sound

    **UI/UX**
- Main menu
- Pause menu
- Options menu
- Loading screens
- Health/UI system

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

### Controls

| Action | Key |
|--------|-----|
| Move Forward | W / Up Arrow |
| Move Backward | S / Down Arrow |
| Move Left/Right | A / D or Left Arrow / Right Arrow|
| Run | Shift |
| Jump | Space |
| Attack | Left Click |
| Shield| Right Click |
| Switch Weapon| Mouse Middle Click|
| Pause | ESC |