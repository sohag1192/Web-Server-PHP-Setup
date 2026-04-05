#!/bin/bash
# ==========================================
# Shell script to auto-run livetv_list.php
# every 5 minutes
# ==========================================

PHP_BIN="/usr/bin/php"
SCRIPT_PATH="/var/www/html/playlist/livetv_list.php"
LOG_FILE="/var/www/html/playlist/livetv_list.log"

while true; do
    echo "[$(date)] Running livetv_list.php..." >> "$LOG_FILE"
    $PHP_BIN "$SCRIPT_PATH" >> "$LOG_FILE" 2>&1
    echo "[$(date)] Completed." >> "$LOG_FILE"
    # Sleep for 5 minutes (300 seconds)
    sleep 300
done