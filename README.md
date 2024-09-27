# matomo-log-scraper

This service runs as a sidecar to the Traefik pod. It rotates the logs daily and sends them to the Matomo server for analysis. 

It keeps 30 days of logs compressed in the PVC on the cluster for debugging purposes.

# Testing

## The Script

```bash
source .env

# Construct the command with the environment variables
python3 import-script/import_logs.py "$LOG_PATH" --dry-run --url "$MATOMO_URL" --token-auth "$API_TOKEN"

# Print out the command that was just ran
echo "python3 import-script/import_logs.py \"$LOG_PATH\" --url \"$MATOMO_URL\" --token-auth \"$API_TOKEN\""
```

## The Docker Image

```bash
docker build -t matomo-log-scraper:latest .
docker run --env-file .env --rm -it -v $PWD/test-logs:/app/test-logs matomo-log-scraper:latest
```
