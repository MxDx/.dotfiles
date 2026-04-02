#!/bin/bash

# 1. Find the correct hwmon path dynamically
# This looks for the folder that contains the name "amdgpu"
HWMON_PATH=$(grep -l "amdgpu" /sys/class/hwmon/hwmon*/name | head -n 1 | rev | cut -d'/' -f2- | rev)

if [ -z "$HWMON_PATH" ]; then
  echo "{\"text\": \"󰢮 --°C\", \"alt\": \"GPU Temp\", \"class\": \"error\"}"
  exit 1
fi

# 2. Read the temp (using a subshell to avoid 'Busy' locking issues)
RAW_TEMP=$(cat "$HWMON_PATH/temp1_input" 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$RAW_TEMP" ]; then
  echo "{\"text\": \"󰢮 Busy\", \"alt\": \"GPU Temp\", \"class\": \"warning\"}"
  exit 1
fi

# 3. Convert millidegrees to Celsius
TEMP=$(echo "scale=1; $RAW_TEMP / 1000" | bc)

echo "{\"text\": \"󰢮 ${TEMP}°C\", \"alt\": \"GPU Temp\", \"class\": \"gpu-temp\"}"
