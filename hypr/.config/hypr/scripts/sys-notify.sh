#!/bin/bash

case $1 in
volume)
  # Get volume and mute status
  VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}')
  ICON="audio-volume-high"
  notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$ICON" -h int:value:"$VOL" "Volume: ${VOL}%"
  ;;
brightness)
  BRIGHT=$(brightnessctl info | grep -oP '\(\K[^%]+')
  notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i display-brightness -h int:value:"$BRIGHT" "Brightness: ${BRIGHT}%"
  ;;
media)
  # Give the player a tiny moment to update metadata
  sleep 0.1
  INFO=$(playerctl metadata --format '{{title}} - {{artist}}')
  notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i media-playback-start "Now Playing" "$INFO"
  ;;
esac
