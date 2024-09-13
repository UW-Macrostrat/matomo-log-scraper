FROM python:3.8

# Install cron
RUN apt-get update -y && apt-get install -y cron

# Set the working directory
WORKDIR /app

# Copy the necessary files
COPY ./import-script/import_logs.py import_logs.py
COPY ./import.sh import.sh
COPY ./logrotate.sh logrotate.sh
COPY ./crontab /etc/cron.d/import-cron

# Make the scripts executable
RUN chmod +x import.sh logrotate.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/import-cron

# Apply cron job
RUN crontab /etc/cron.d/import-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Start the cron service and the application
CMD cron && tail -f /var/log/cron.log