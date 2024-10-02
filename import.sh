#!/bin/sh

# This file is run on successful log rotation

# Define the log file and the rotated log file
ROTATED_LOG_FILE="$LOG_PATH.1"

# Check if the rotated log file exists
if [ -f "$ROTATED_LOG_FILE" ]; then
    echo "Log rotation successful. Processing the rotated log file."
    # Call the import script
    python3 /app/import_logs.py "$ROTATED_LOG_FILE" --url "$MATOMO_URL" --token-auth "$API_TOKEN"

    # Find the PID of the traefik process
    TRAEFIK_PID=$(pgrep traefik)

    # Check if the PID was found
    if [ -n "$TRAEFIK_PID" ]; then
        # Send USR1 signal to the traefik process
        kill -USR1 "$TRAEFIK_PID"
        echo "Sent USR1 signal to traefik process with PID $TRAEFIK_PID"
    else
        echo "Traefik process not found."
        exit 1
    fi
else
    echo "Rotated log file not found."
    exit 1
fi
