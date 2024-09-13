# matomo-log-scraper

This service runs as a sidecar to the Traefik pod. It rotates the logs daily and sends them to the Matomo server for analysis. 

It keeps 30 days of logs compressed in the PVC on the cluster for debugging purposes.

# Testing

```bash
source .env

# Construct the command with the environment variables
python3 import-script/import_logs.py "$LOG_PATH" --dry-run --url "$MATOMO_URL" --token-auth "$API_TOKEN"
```

