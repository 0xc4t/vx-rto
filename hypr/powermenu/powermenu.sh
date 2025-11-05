#!/bin/env bash

lock=" "
logout=" "
shutdown=" "
sleep=" "

selected_option=$(echo "$lock
$logout
$sleep
$shutdown" | rofi -dmenu\
                  -i\
                  -p "Power"\
		 -theme "$HOME/.config/hypr/powermenu/powermenu.rasi")

if [ "$selected_option" == "$lock" ]
then
    hyprlock -c $HOME/.config/hyprlock/hyprlock.conf
elif [ "$selected_option" == "$logout" ]
then
    hyprctl dispatch exit
elif [ "$selected_option" == "$shutdown" ]
then
    poweroff
elif [ "$selected_option" == "$sleep" ]
then
    doas systemctl suspend
else
    echo "No match"
fi
