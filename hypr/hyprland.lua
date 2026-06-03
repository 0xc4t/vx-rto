-- Main Hyprland Lua entrypoint.
-- Hyprland 0.55 loads this file instead of hyprland.conf when it exists.

require("conf/env")
require("conf/monitor")
require("conf/look-and-feel")
require("conf/animations")
require("conf/input")
require("conf/windowrule")
require("conf/keybindings")
require("conf/autostart")

-- Legacy conf files that were present but not sourced by hyprland.conf:
-- conf/workspaces.conf
-- conf/hyprscrolling.conf
