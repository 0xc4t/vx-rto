#!/usr/bin/env bash
set -euo pipefail

window_json=$(niri msg -j focused-window 2>/dev/null || true)

if [[ -z "$window_json" || "$window_json" == "null" ]]; then
    exit 0
fi

is_floating=$(jq -r '.is_floating // false' <<<"$window_json")

if [[ "$is_floating" == "true" ]]; then
    niri msg action move-window-to-tiling
else
    niri msg action move-window-to-floating
    niri msg action set-window-width 1000
    niri msg action set-window-height 700
    niri msg action center-window
fi
