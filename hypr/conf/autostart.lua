local commands = {
    "waybar -c $HOME/.config/waybar/mocha/config.jsonc -s $HOME/.config/waybar/mocha/style.css & awww-daemon",
    "awww img $HOME/.config/wallpaper/default.jpg --transition-fps 60 --transition-type any --transition-duration 3",
    "copyq --start-server",
    "wl-paste --type text --watch cliphist store",
    "wl-paste --type image --watch cliphist store",
    "xrdb -merge ~/.Xresources",
    "swaync -s ~/.config/swaync/style.css",
    "eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)",
    "$HOME/.local/bin/hyprland.sh",
    "vicinae server",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
    "dbus-update-activation-environment --systemd --all",
    "systemctl --user import-environment QT_QPA_PLATFORMTHEME",
}

hl.on("hyprland.start", function()
    for _, command in ipairs(commands) do
        hl.exec_cmd(command)
    end
end)
