local env = {
    { "GDK_BACKEND", "wayland,x11" },
    { "XCURSOR_SIZE", "24" },
    { "HYPRCURSOR_SIZE", "24" },
    { "QT_QPA_PLATFORMTHEME", "qt5ct" },
    { "QT_QPA_PLATFORM", "wayland;xcb" },
    { "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
    { "QT_AUTO_SCREEN_SCALE_FACTOR", "1" },
    { "XCURSOR_THEME", "catppuccin-mocha-lavender-cursors" },
    { "QT_STYLE_OVERRIDE", "kvantum" },
    { "XDG_CURRENT_DESKTOP", "Hyprland" },
    { "XDG_SESSION_TYPE", "wayland" },
    { "XDG_SESSION_DESKTOP", "Hyprland" },
    { "HYPRLAND_RENDERER", "opengl" },
    { "_JAVA_AWT_WM_NONREPARENTING", "1" },
}

for _, item in ipairs(env) do
    hl.env(item[1], item[2])
end
