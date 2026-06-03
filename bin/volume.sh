#!/bin/bash

# Get Volume
get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d. -f1
}

# Get Mute Status
is_mute() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "\[MUTED\]" && echo "yes" || echo "no"
}

# Send Notification
send_notification() {
    volume=$(get_volume)
    mute=$(is_mute)
    
    if [ "$mute" == "yes" ]; then
        notify-send -u low -h string:x-canonical-private-synchronous:volume_notif -h int:value:0 -i audio-volume-muted-symbolic "Muted" "Volume is muted"
    else
        # Choose icon based on volume level
        if [ "$volume" -lt "33" ]; then
            icon="audio-volume-low-symbolic"
        elif [ "$volume" -lt "66" ]; then
            icon="audio-volume-medium-symbolic"
        else
            icon="audio-volume-high-symbolic"
        fi
        notify-send -u low -h string:x-canonical-private-synchronous:volume_notif -h int:value:"$volume" -i "$icon" "Volume: $volume%"
    fi
}

case $1 in
    up)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
        send_notification
        ;;
    down)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        send_notification
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        send_notification
        ;;
esac
