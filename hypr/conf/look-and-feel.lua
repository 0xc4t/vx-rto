local colors = require("conf/mocha")

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgba(" .. colors.lavender_alpha .. "aa)",
            inactive_border = "rgb(2a273f)",
        },
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        rounding_power = 2,

        shadow = {
            enabled = true,
            range = 2,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },

        blur = {
            enabled = true,
            size = 10,
            passes = 2,
            new_optimizations = true,
            ignore_opacity = true,
            noise = 0.01,
            contrast = 0.8,
            vibrancy = 0.2,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
        animate_manual_resizes = false,
        disable_splash_rendering = false,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    scrolling = {
        column_width = 0.7,
        fullscreen_on_one_column = true,
        follow_min_visible = 0.1,
        focus_fit_method = 1,
        explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
        follow_focus = true,
    },
})
