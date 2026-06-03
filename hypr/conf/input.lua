hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        repeat_rate = 40,
        repeat_delay = 600,
        follow_mouse = 1,
        sensitivity = 0.1,
        numlock_by_default = true,
        force_no_accel = false,

        touchpad = {
            natural_scroll = true,
            tap_to_click = true,
            scroll_factor = 0.4,
        },
    },

    cursor = {
        no_hardware_cursors = true,
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.device({
    name = "2.4g-mouse-1",
    sensitivity = -0.3,
    scroll_factor = 0.6,
})

hl.device({
    name = "2.4g-mouse-consumer-control-1",
    sensitivity = -0.3,
    scroll_factor = 0.6,
})

hl.device({
    name = "rexus-qz30-2-keyboard-1",
    sensitivity = -0.4,
})

hl.device({
    name = "rexus-qz30-2-mouse",
    sensitivity = -0.4,
})

hl.device({
    name = "tpps/2-elan-trackpoint",
    sensitivity = -0.6,
})
