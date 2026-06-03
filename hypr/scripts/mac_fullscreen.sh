#!/usr/bin/env bash

window_info=$(hyprctl activewindow -j)
address=$(echo "$window_info" | jq -r '.address')
fullscreen=$(echo "$window_info" | jq -r '.fullscreen')
current_ws=$(echo "$window_info" | jq -r '.workspace.id')

state_file="$HOME/.cache/hypr_mac_fs_${address}.txt"

if [[ "$fullscreen" == "0" || "$fullscreen" == "false" ]]; then
    echo "$current_ws" > "$state_file"
    
    hyprctl dispatch movetoworkspace "empty,address:${address}"
    
    sleep 0.3
    
    hyprctl dispatch fullscreen 0
else
    hyprctl dispatch fullscreen 0
    
    sleep 0.3
    
    # Pulang ke workspace asal kalau file jejaknya ada
    if [[ -f "$state_file" ]]; then
        orig_ws=$(cat "$state_file")
        hyprctl dispatch movetoworkspace "${orig_ws},address:${address}"
        rm "$state_file"
    fi
fi
