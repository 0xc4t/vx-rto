# Hyprland Keybindings

This document provides a full overview of the keybindings used in my Hyprland dotfiles. It serves as a reference for maintenance, customization, and troubleshooting.

---

## 📌 Variables

| Variable       | Value                                           | Description          |
| -------------- | ----------------------------------------------- | -------------------- |
| `$terminal`    | `kitty -c $HOME/.config/kitty/kitty.conf` | Default terminal     |
| `$fileManager` | `thunar`                                        | File manager         |
| `$menu`        | `vicinae open`                                  | Application launcher |
| `$mainMod`     | `SUPER`                                         | Main modifier key    |

---

## 🔌 System Controls

| Key                     | Action                                    |
| ----------------------- | ----------------------------------------- |
| `XF86PowerOff`          | Open power menu (`powermenu.sh`)          |
| `XF86MonBrightnessDown` | Decrease brightness by 10%                |
| `XF86MonBrightnessUp`   | Increase brightness by 10%                |
| `XF86AudioRaiseVolume`  | Increase volume by 10%                    |
| `XF86AudioLowerVolume`  | Decrease volume by 10%                    |
| `XF86AudioMute`         | Toggle audio mute + run `toggle-audio.sh` |
| `XF86AudioMicMute`      | Toggle microphone mute                    |

---

## 🎨 Custom Scripts

| Key         | Action               |
| ----------- | -------------------- |
| `SUPER + w` | Run `wall_picker.sh` |
| `SUPER + G` | Launch Ghidra        |

---

## 🪟 Window Management

| Key                     | Action                     |
| ----------------------- | -------------------------- |
| `SUPER + F`             | Toggle fullscreen mode     |
| `SUPER + L`             | Lock screen using Hyprlock |
| `SUPER + Return`        | Open terminal              |
| `SUPER + Q`             | Kill active window         |
| `SUPER + M`             | Exit Hyprland              |
| `SUPER + I`             | Open file manager          |
| `SUPER + SHIFT + SPACE` | Toggle floating mode       |
| `Print`                 | Take screenshot            |
| `SUPER + D`             | Open application launcher  |
| `SUPER + P`             | Toggle pseudo layout       |
| `SUPER + J`             | Toggle split direction     |

### Move Window

| Key                     | Action            |
| ----------------------- | ----------------- |
| `SUPER + SHIFT + Left`  | Move window left  |
| `SUPER + SHIFT + Right` | Move window right |
| `SUPER + SHIFT + Up`    | Move window up    |
| `SUPER + SHIFT + Down`  | Move window down  |

### Move Focus

| Key             | Action      |
| --------------- | ----------- |
| `SUPER + Left`  | Focus left  |
| `SUPER + Right` | Focus right |
| `SUPER + Up`    | Focus up    |
| `SUPER + Down`  | Focus down  |

---

## 🔢 Workspaces

### Switch Workspace

| Key         | Workspace    |
| ----------- | ------------ |
| `SUPER + 1` | Workspace 1  |
| `SUPER + 2` | Workspace 2  |
| `SUPER + 3` | Workspace 3  |
| `SUPER + 4` | Workspace 4  |
| `SUPER + 5` | Workspace 5  |
| `SUPER + 6` | Workspace 6  |
| `SUPER + 7` | Workspace 7  |
| `SUPER + 8` | Workspace 8  |
| `SUPER + 9` | Workspace 9  |
| `SUPER + 0` | Workspace 10 |

### Move Window to Workspace

| Key                 | Workspace            |
| ------------------- | -------------------- |
| `SUPER + SHIFT + 1` | Move to workspace 1  |
| `SUPER + SHIFT + 2` | Move to workspace 2  |
| `SUPER + SHIFT + 3` | Move to workspace 3  |
| `SUPER + SHIFT + 4` | Move to workspace 4  |
| `SUPER + SHIFT + 5` | Move to workspace 5  |
| `SUPER + SHIFT + 6` | Move to workspace 6  |
| `SUPER + SHIFT + 7` | Move to workspace 7  |
| `SUPER + SHIFT + 8` | Move to workspace 8  |
| `SUPER + SHIFT + 9` | Move to workspace 9  |
| `SUPER + SHIFT + 0` | Move to workspace 10 |

---

## 🪄 Special Workspace

| Key                 | Action                                   |
| ------------------- | ---------------------------------------- |
| `SUPER + S`         | Toggle special workspace "magic"         |
| `SUPER + SHIFT + S` | Move window to special workspace "magic" |

---

## 🖱 Mouse Bindings

| Binding                     | Action                       |
| --------------------------- | ---------------------------- |
| `SUPER + Mouse Left (272)`  | Move window                  |
| `SUPER + Mouse Right (273)` | Resize window                |
| `SUPER + mouse_down`        | Switch to next workspace     |
| `SUPER + mouse_up`          | Switch to previous workspace |

---

## 🧩 Window Rules

```
windowrulev2 = suppressevent maximize, class:.*
```

This rule suppresses maximize events for all applications.

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
