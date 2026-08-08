#!/usr/bin/env bash
set -euo pipefail

APP_NAME="onedrive-rclone"
REMOTE_NAME="${ONEDRIVE_REMOTE:-Onedrive:}"
MOUNTPOINT="${ONEDRIVE_MOUNTPOINT:-$HOME/OneDrive}"
CACHE_DIR="${ONEDRIVE_CACHE_DIR:-$HOME/.cache/rclone}"
LOGFILE="${ONEDRIVE_LOGFILE:-$HOME/.local/state/$APP_NAME/rclone.log}"
INDICATOR="${ONEDRIVE_INDICATOR:-$HOME/.local/share/$APP_NAME/onedrive_indicator.py}"

mkdir -p "$MOUNTPOINT" "$(dirname "$LOGFILE")" "$CACHE_DIR"

if mountpoint -q "$MOUNTPOINT"; then
  echo "OneDrive ya está montado en $MOUNTPOINT"
else
  nohup rclone mount "$REMOTE_NAME" "$MOUNTPOINT" \
    --vfs-cache-mode full \
    --dir-cache-time 5m \
    --poll-interval 1m \
    --allow-non-empty \
    --volname "OneDrive" \
    --vfs-cache-max-size 150G \
    --vfs-cache-max-age 720h \
    >"$LOGFILE" 2>&1 &

  sleep 2

  if mountpoint -q "$MOUNTPOINT"; then
    echo "OneDrive montado en $MOUNTPOINT"
  else
    echo "No se pudo montar OneDrive. Revisa $LOGFILE"
    exit 1
  fi
fi

xdg-open "$MOUNTPOINT" >/dev/null 2>&1 &

if [ -x "$INDICATOR" ] && ! pgrep -f "$INDICATOR" >/dev/null 2>&1; then
  nohup "$INDICATOR" >/dev/null 2>&1 &
fi
