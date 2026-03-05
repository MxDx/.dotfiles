#!/bin/bash

# 1. Define paths
WALLPAPER=$1
TARGET_DIR="$HOME/.config/backgrounds"
DEFAULT_WALL="$TARGET_DIR/default.png"

# 2. Check if a file was provided
if [ -z "$WALLPAPER" ]; then
  echo "Usage: ./set-wallpaper.sh /path/to/image.jpg"
  exit 1
fi

# 3. Ensure target directory exists
mkdir -p "$TARGET_DIR"

# 4. Apply the wallpaper using swww
# Using 'grow' transition for a nice effect
if swww img "$WALLPAPER" --transition-type grow --transition-pos center; then
  echo "Wallpaper applied: $WALLPAPER"

  # 5. Copy to default.png
  cp "$WALLPAPER" "$DEFAULT_WALL"
  echo "Saved as default at $DEFAULT_WALL"
else
  echo "Error: Could not set wallpaper. Is swww-daemon running?"
  exit 1
fi
