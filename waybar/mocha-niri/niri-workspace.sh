#!/bin/sh

idx=${1:?workspace index required}

case "$idx" in
  1) label="一" ;;
  2) label="二" ;;
  3) label="三" ;;
  4) label="四" ;;
  5) label="五" ;;
  6) label="六" ;;
  7) label="七" ;;
  8) label="八" ;;
  9) label="九" ;;
  10) label="十" ;;
  *) label="$idx" ;;
esac

if ! workspaces=$(niri msg -j workspaces 2>/dev/null); then
  jq -cn \
    --arg text "$label" \
    '{text: $text, class: ["niri-workspace", "unavailable"]}'
  exit 0
fi

printf '%s\n' "$workspaces" | jq -c \
  --arg idx "$idx" \
  --arg label "$label" '
    any(.[]; (.idx | tostring) == $idx) as $exists
    | {
        text: (if $exists then "" else $label end),
        class: ["niri-workspace", (if $exists then "hidden" else "empty" end)]
      }
  '
