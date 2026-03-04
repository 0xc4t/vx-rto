#!/usr/bin/env bash


if hyprctl monitors | grep -q "DP-1"; then
    if [[ $1 == "open" ]]; then
        hyprctl keyword monitor "eDP-1,1920x1200@60.0,322x1440,1.0"
    else
        hyprctl keyword monitor "eDP-1,disable"
    fi
fi



