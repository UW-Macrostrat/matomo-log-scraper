#!/bin/sh

echo "Running logrotate"

# Create a temporary logrotate configuration file
cat <<EOF > /tmp/logrotate.conf
"$LOG_PATH" {
    daily
    rotate 31
    compress
    delaycompress
    postrotate
        /app/import.sh
    endscript
}
EOF

cat /tmp/logrotate.conf

# Run logrotate with the temporary configuration file
/usr/sbin/logrotate -v /tmp/logrotate.conf

# Clean up the temporary configuration file
rm /tmp/logrotate.conf
