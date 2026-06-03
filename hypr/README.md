# My Hyprland Configuration

Welcome to my personal [Hyprland](https://hyprland.org/) configuration! This dots setup is organized with modularity and ease-of-use in mind, keeping different configuration aspects cleanly separated within the `conf/` directory.

## 📂 Directory Structure

- `hyprland.conf`: The main entrypoint that sources all modular configurations.
- `conf/`: Contains modular settings like keybindings, window rules, animations, monitors, and inputs.
- `scripts/`: Custom utility scripts, if any.

## ⌨️ Keybindings

The primary modifier key (`$mainMod`) for this setup is the **SUPER** (Windows/Command) key. Below is the list of active keybindings configured in `conf/keybindings.conf`.

### 🚀 Applications & System

| Shortcut | Action | Command/App |
| :--- | :--- | :--- |
| `SUPER + Enter` | Launch Terminal | Kitty (`~/.config/kitty/kitty.conf`) |
| `SUPER + SHIFT + Enter` | Launch Secondary Terminal | Ghostty |
| `SUPER + D` | Open App Launcher | `vicinae open` |
| `SUPER + I` | Open File Manager | Thunar |
| `SUPER + L` | Lock Screen | `hyprlock` |
| `Print` | Take Screenshot | `screenshot` |
| `SUPER + SHIFT + P` | Take Screenshot | `screenshot` |
| `SUPER + M` | Exit Hyprland | |

### 🪟 Window Management

| Shortcut | Action |
| :--- | :--- |
| `SUPER + Q` | Close / Kill Active Window |
| `SUPER + F` | Toggle Fullscreen |
| `SUPER + P` | Pseudo Tiling |
| `SUPER + J` | Toggle Split Layout |
| `SUPER + SHIFT + Space` | Floating Toggle + Center + Resize (1000x700) |
| `SUPER + Arrow Keys` | Move Focus (Up/Down/Left/Right) |
| `SUPER + SHIFT + Arrow Keys` | Move Active Window (Up/Down/Left/Right) |

### 🖥️ Workspaces

| Shortcut | Action |
| :--- | :--- |
| `SUPER + [1-0]` | Switch to Workspace 1 - 10 |
| `SUPER + SHIFT + [1-0]`| Move Window to Workspace 1 - 10 |
| `SUPER + S` | Toggle Special Workspace ("magic") |
| `SUPER + SHIFT + S` | Move Window to Special Workspace |
| `SUPER + Scroll Up` | Go to Previous Workspace |
| `SUPER + Scroll Down`| Go to Next Workspace |

### 🖱️ Mouse Bindings

| Shortcut | Action |
| :--- | :--- |
| `SUPER + Left Click` | Move Floating Window |
| `SUPER + Right Click` | Resize Floating Window |

### 🔉 Hardware Controls

| Shortcut | Action |
| :--- | :--- |
| `XF86MonBrightnessUp` | Increase Brightness (+10%) |
| `XF86MonBrightnessDown`| Decrease Brightness (-10%) |
| `XF86AudioRaiseVolume` | Increase Audio Volume (+10%) |
| `XF86AudioLowerVolume` | Decrease Audio Volume (-10%) |
| `XF86AudioMicMute` | Toggle Microphone Mute |

---
*Created automatically based on the current configuration layout.*
