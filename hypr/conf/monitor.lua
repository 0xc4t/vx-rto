hl.monitor({
    output = "eDP-1",
    mode = "1920x1200@60.0",
    position = "316x1440",
    scale = 1.0,
})

hl.monitor({
    output = "DP-3",
    mode = "2560x1440@180.0",
    position = "0x0",
    scale = 1.0,
})

hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/clamshell.sh open"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/clamshell.sh close"), { locked = true })
