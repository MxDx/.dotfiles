#!/bin/bash
# Get temp from nvidia-smi (or change to amdgpu path if using AMD)
TEMP=$(cat /sys/class/drm/card1/device/hwmon/hwmon4/temp1_input)

# Divide by 1000 to convert from millidegrees to degrees Celsius
TEMP=$(echo "scale=1; $TEMP / 1000" | bc)

# Output JSON for ashell
echo "{\"text\": \"󰢮 ${TEMP}°C\", \"alt\": \"normal\", \"class\": \"gpu-temp\"}"
