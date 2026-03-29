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


## Preview
<img width="1921" height="1078" alt="image" src="https://github.com/user-attachments/assets/e0317bcb-cac6-4267-9387-5f1e82552eed" />

<img width="1921" height="1075" alt="image" src="https://github.com/user-attachments/assets/38e83691-5c85-48c3-b615-d7fb8f291bd6" />

## New Waybar Style
<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/298668ff-36eb-4795-bc27-1a99618fb5d2" />

### Neovim
<img width="1920" height="1074" alt="image" src="https://github.com/user-attachments/assets/e6ec8962-3587-4cf3-b00e-89ca7a7b2a2a" />

<img width="1921" height="1076" alt="image" src="https://github.com/user-attachments/assets/691131bf-c24d-413e-85c8-b364f4ba3376" />

### Swaync Notification Bar
<img width="1921" height="1074" alt="image" src="https://github.com/user-attachments/assets/09d8c856-aa38-4e96-a14a-e041b3957263" />

### Menu
<img width="1921" height="1076" alt="image" src="https://github.com/user-attachments/assets/337e1e78-768e-47bc-9d20-ba3fafdbd05b" />

### Virtual Machine
<img width="1921" height="1077" alt="image" src="https://github.com/user-attachments/assets/8624b5c7-0bcc-48ca-bc90-779cc156611b" />
