local window_rules = {
    {
        name = "xwayland-video-bridge-fixes",
        match = { class = "xwaylandvideobridge" },
        no_initial_focus = true,
        no_focus = true,
        no_anim = true,
        no_blur = true,
        max_size = { 1, 1 },
        opacity = "0.0",
    },
    { name = "zoom-refinement", match = { class = "^(zoom)$", title = "^(Zoom Workplace)$" }, opacity = "0.95 0.95" },
    { name = "windowrule-1", match = { class = "^(org.telegram.desktop)$" }, opacity = "0.95 0.95" },
    { name = "windowrule-2", match = { class = "^(Code)$" }, opacity = "0.95 0.95" },
    { name = "disable-border-only-office", match = { class = "^(ONLYOFFICE)$" }, border_size = 0 },
    { name = "windowrule-3", match = { class = "^(code-url-handler)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-4", match = { class = "^(code-insiders-url-handler)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-5", match = { class = "^(org.pulseaudio.pavucontrol)$" }, opacity = "0.90 0.90", float = true, size = { 920, 450 } },
    { name = "nmgui-windowrule", match = { class = "^(com.network.manager)$" }, opacity = "0.90 0.90", float = true },
    { name = "windowrule-6", match = { class = "^(qt5ct)$" }, opacity = "0.90 0.90", float = true },
    { name = "windowrule-7", match = { class = "^(qt6ct)$" }, opacity = "0.90 0.90", float = true },
    { name = "windowrule-8", match = { class = "^(kitty)$" }, opacity = "1 1" },
    { name = "windowrule-9", match = { class = "^(org.kde.ark)$" }, opacity = "0.90 0.90", float = true },
    { name = "windowrule-10", match = { class = "^(com.obsproject.Studio)$" }, opacity = "0.95 0.95" },
    { name = "windowrule-11", match = { class = "^(Thunar)$" }, opacity = "0.92 0.92" },
    { name = "windowrule-12", match = { class = "^(thunar)$" }, opacity = "0.92 0.92" },
    { name = "windowrule-13", match = { class = "^(blueman-manager)$" }, opacity = "0.90 0.90", float = true },
    { name = "windowrule-14", match = { class = "^(steamwebhelper)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-15", match = { class = "^(discord)$" }, opacity = "0.98 0.98" },
    { name = "windowrule-16", match = { class = "^(org.telegram.desktop._cc56ebf4782c34c32f1a976289a609d6)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-17", match = { class = "^(WebCord)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-18", match = { class = "^(Spotify)$" }, opacity = "0.95 0.95" },
    { name = "windowrule-19", match = { class = "^(yad)$" }, opacity = "0.90 0.90", float = true },
    { name = "windowrule-20", match = { class = "^(org.kde.polkit-kde-authentication-agent-1)$" }, opacity = "0.90 0.90", float = true },
    { name = "windowrule-21", match = { class = "^(polkit-gnome-authentication-agent-1)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-22", match = { class = "^(org.freedesktop.impl.portal.desktop.gtk)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-23", match = { class = "^(org.freedesktop.impl.portal.desktop.hyprland)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-24", match = { class = "^(org.gnome.Loupe)$" }, opacity = "0.90 0.90", float = true, center = true, size = { 1200, 900 } },
    { name = "windowrule-25", match = { class = "^(gnome-calculator)$" }, opacity = "0.90 0.90", float = true, center = true, size = { 360, 500 } },
    { name = "windowrule-26", match = { class = "^(evince)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-27", match = { class = "^(re.rizin.cutter)$" }, opacity = "0.90 0.90" },
    { name = "windowrule-28", match = { class = "^(burp-StartBurp)$" }, opacity = "100 100" },
    { name = "windowrule-29", match = { class = "^(com.gabm.satty)$" }, float = true },
    { name = "windowrule-30", match = { class = "^(com.network.manager)$" }, float = true },
    { name = "windowrule-31", match = { class = "^(hyprland-share-picker)$" }, float = true },
    { name = "windowrule-32", match = { class = "^(steam)$", title = "negative:^(Steam)$" }, float = true },
    { name = "windowrule-33", match = { title = "^(Java)$" }, no_anim = true, float = true, move = { 9999, 9999 } },
    { name = "windowrule-34", match = { class = "^(Java)$" }, border_size = 0 },
    { name = "windowrule-35", match = { class = "^(mpv)$" }, float = true },
    { name = "windowrule-36", match = { class = "^(firefox)$", title = "^(Picture-in-Picture)$" }, float = true },
    { name = "windowrule-37", match = { class = "^(firefox)$", title = "^(Library)$" }, float = true },
    { name = "windowrule-38", match = { class = "^()$", title = "^()$" }, no_blur = true },
}

for _, spec in ipairs(window_rules) do
    hl.window_rule(spec)
end

local layer_rules = {
    { name = "layerrule-1", match = { namespace = "selection" }, no_anim = true },
    { name = "layerrule-2", match = { namespace = "waybar" }, blur = true, ignore_alpha = 0 },
    { name = "layerrule-3", match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 1.0 },
    { name = "layerrule-4", match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 1.0 },
    { name = "layerrule-10", match = { namespace = "waybar" }, blur = true, ignore_alpha = 0 },
}

for _, spec in ipairs(layer_rules) do
    hl.layer_rule(spec)
end
