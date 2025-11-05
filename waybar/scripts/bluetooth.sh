#!/bin/bash

if bluetoothctl show | grep -q "Powered: yes"; then
    if bluetoothctl info | grep -q "Connected: yes"; then
        echo "<span color='#cba6f7'></span> <span color='#cdd6f4'>Connected </span>"
    else
        echo "<span color='#cba6f7'></span> <span color='#cdd6f4'>Disconnected </span>"
    fi
else
    echo "<span color='#cba6f7'></span> <span color='#cdd6f4'>Disabled </span>"
fi
