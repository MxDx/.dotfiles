#!/bin/bash

# Configuration: Replace with your actual service and timer names
SERVICE="pbs-backup-default.service"
TIMER="pbs-backup-default.timer"

# Get status from systemctl
IS_RUNNING=$(systemctl is-active "$SERVICE")
TIMER_INFO=$(systemctl list-timers "$TIMER" --no-legend)

ACTIVE_STATE=$(systemctl show "$SERVICE" --property=ActiveState --value)
EXIT_CODE=$(systemctl show "$SERVICE" --property=ExecMainStatus --value)

START_TS=$(systemctl show "$SERVICE" --property=ExecMainStartTimestamp --value)
EXIT_TS=$(systemctl show "$SERVICE" --property=ExecMainExitTimestamp --value)

# Calculate duration if available
if [ -n "$START_TS" ] && [ -n "$EXIT_TS" ]; then
  START_SEC=$(date -d "$START_TS" +%s)
  EXIT_SEC=$(date -d "$EXIT_TS" +%s)
  DURATION=$((EXIT_SEC - START_SEC))
  # Convert seconds to M:S format
  MINS=$((DURATION / 60))
  SECS=$((DURATION % 60))
  DURATION_STR="${MINS}m ${SECS}s"
else
  DURATION_STR="N/A"
fi

# Parse timer info (Next, Left, Last, Passed)
# NEXT_RUN=$(echo "$TIMER_INFO" | awk '{print $3, $4, $5}')
NEXT_RUN=$(echo "$TIMER_INFO" | awk '{print $2" "$3}')
TIME_LEFT=$(echo "$TIMER_INFO" | awk '{print $5" "$6}')
LAST_RUN=$(echo "$TIMER_INFO" | awk '{print $8" "$9}')
TIME_AGO=$(echo "$TIMER_INFO" | awk '{print $11" "$12}')

LAST_RESULT=$(systemctl show "$SERVICE" --property=ExecMainStatus --value)
LAST_EXIT_CODE=$(systemctl show "$SERVICE" --property=ExecMainCode --value)

# Determine Icon and Text
if [ "$IS_RUNNING" = "activating" ]; then
  ICON="󱑓"
  STATUS="Backing up..."
  CLASS="running"
  HEADER="<span color='#89b4fa'><b>󱑓 PBS: BACKUP IN PROGRESS</b></span>"
elif [ "$EXIT_CODE" = "0" ] && [ "$LAST_RESULT" = "0" ]; then
  ICON="󰸞"
  STATUS="Last Backup Successful"
  CLASS="success"
  HEADER="<span color='#a6e3a1'><b>󰸞 PBS: ALL CLEAR</b></span>"
else
  ICON="󰅚"
  STATUS="Last Backup Failed"
  CLASS="failed"
  HEADER="<span color='#f38ba8'><b>󰅚 PBS: ERROR DETECTED</b></span>"
fi

# Tooltip content
# Build a "Beautiful" Tooltip using Pango markup
TOOLTIP="${HEADER}\n\n"
TOOLTIP+="📅 <b>Next Run:</b>  $TIME_LEFT ($NEXT_RUN)\n"
TOOLTIP+="🕒 <b>Last Run:</b>  $TIME_AGO ($LAST_RUN)\n"
TOOLTIP+="⏱️ <b>Last Duration:</b>  $DURATION_STR\n"
TOOLTIP+="⚙️ <b>Service:</b>   $SERVICE\n"
TOOLTIP+=" <b>Status:</b>    $IS_RUNNING"

# Output JSON for Waybar
printf '{"text": "%s %s", "tooltip": "%s", "class": "%s"}\n' "$ICON" "$STATUS" "$TOOLTIP" "$CLASS"
