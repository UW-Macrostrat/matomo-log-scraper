#!/bin/sh

# Define the log file and the rotated log file
ROTATED_LOG_FILE="$LOG_PATH.1"

# Check if the rotated log file exists
if [ -f "$ROTATED_LOG_FILE" ]; then
    echo "Log rotation successful. Processing the rotated log file."
    # Call the import script
    python3 /app/import_logs.py --dry-run "$ROTATED_LOG_FILE" --url "$MATOMO_URL" --token-auth "$API_TOKEN"
else
    echo "Rotated log file not found."
    exit 1
fi
