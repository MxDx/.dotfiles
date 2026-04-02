#!/bin/bash

# Configuration
BATTERY="BAT1"
PATH_BASE="/sys/class/power_supply/$BATTERY"
STATUS=$(cat "$PATH_BASE/status")

# Check if battery exists to avoid errors
if [ ! -d "$PATH_BASE" ]; then
  echo "{\"text\": \"No Bat\", \"class\": \"error\"}"
  exit 1
fi

# Read values (in micro-units)
CURRENT=$(cat "$PATH_BASE/current_now")
VOLTAGE=$(cat "$PATH_BASE/voltage_now")

# Calculate Wattage: (Current * Voltage) / 1,000,000,000,000
# We use bc for floating point math
WATTAGE=$(echo "scale=2; ($CURRENT * $VOLTAGE) / 1000000000000" | bc)

# Set Icon and Class based on Status
case "$STATUS" in
"Charging")
  ICON="󰚥" # Plug/Discharge icon
  CLASS="charging"
  ;;
"Discharging")
  ICON="󱐋" # Lightning bolt
  CLASS="discharging"
  ;;
"Full")
  ICON="󰁹" # Full battery
  CLASS="full"
  ;;
*)
  ICON="󱐋" # Lightning bolt
  CLASS="unknown"
  ;;
esac

# Output JSON for ashell
echo "{\"text\": \"$ICON ${WATTAGE}W\", \"alt\": \"$STATUS\", \"class\": \"$CLASS\"}"
