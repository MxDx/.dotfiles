#!/bin/bash
# Identify your CPU sensor path (usually coretemp or k10temp)
# Replace hwmon2 with your actual CPU hwmon number
RAW_TEMP=$(cat /sys/class/hwmon/hwmon6/temp1_input)

# Convert to Celsius with one decimal point
TEMP=$(echo "scale=1; $RAW_TEMP / 1000" | bc)

# Output JSON for ashell
echo "{\"text\": \"󰍛 ${TEMP}°C\", \"alt\": \"normal\", \"class\": \"cpu-temp\"}"
