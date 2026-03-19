#!/bin/bash

# Configuration: Battery percentage to hibernate at
THRESHOLD=5

# Get battery percentage (Change BAT0 to BAT1 if needed)
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
# Get charging status
STATUS=$(cat /sys/class/power_supply/BAT1/status)

# Only hibernate if discharging and below threshold
if [ "$BATTERY_LEVEL" -le "$THRESHOLD" ] && [ "$STATUS" == "Discharging" ]; then
  notify-send -u critical "🪫 Critical Battery" "Battery at ${BATTERY_LEVEL}%. Hibernating now..."
  sleep 2 # Give the notification a second to show
  systemctl hibernate
fi
