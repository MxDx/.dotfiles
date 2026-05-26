#!/bin/bash

if pgrep -x ashell >/dev/null; then
  echo "ashell is already running."
  exit 0
fi

ICED_BACKEND=tiny-skia ashell | systemd-cat -t ashell
