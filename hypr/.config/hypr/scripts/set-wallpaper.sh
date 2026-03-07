#!/bin/bash

# 1. Define paths
TARGET_DIR="$HOME/.config/backgrounds"

# 2. Logic to determine which wallpaper to use
if [ -z "$1" ]; then
  # No file provided, look for default.*
  # We use a glob and an array to safely pick the first match
  DEFAULTS=("$TARGET_DIR"/default)

  if [ -e "${DEFAULTS[0]}" ]; then
    WALLPAPER="${DEFAULTS[0]}"
    echo "No image provided. Loading default: $WALLPAPER"
  else
    echo "Error: No image provided and no default.* found in $TARGET_DIR"
    exit 1
  fi
else
  # Image was provided via argument
  WALLPAPER="$1"
fi

# 3. Ensure target directory exists (for future saves)
mkdir -p "$TARGET_DIR"

# 4. Apply the wallpaper using swww
if swww img "$WALLPAPER" --transition-type grow --transition-pos center; then
  echo "Wallpaper applied: $WALLPAPER"

  # 5. Only update default if a NEW wallpaper was provided
  # (Avoids copying default.* onto itself)
  if [ ! -z "$1" ]; then
    # Get the extension of the new wallpaper
    EXT="${WALLPAPER##*.}"

    # Remove old default files to prevent clutter (default.jpg, default.png, etc.)
    rm -f "$TARGET_DIR"/default

    # Save new default
    cp "$WALLPAPER" "$TARGET_DIR/default"
    echo "Saved as new default: default"
  fi
else
  echo "Error: Could not set wallpaper. Is swww-daemon running?"
  exit 1
fi
