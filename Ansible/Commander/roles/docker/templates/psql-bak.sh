#!/bin/bash
# could probably optimize later with loop if backups > 10

# Backup settings
backup_dir="/var/backupz/postgres"
database_terrafrom="terraform_backend"
database_auth_real="authelia_real"
database_auth_test="authelia_test"
nas_dir="/mnt/GenBackup/Postgres"

retention_period=30 # Number of days to retain backups

# Discord webhook settings
discord_webhook_url="{{ discord_webhook }}"

# Function to send Discord notification
send_discord_notification() {
  local message="$1"
  local discord_payload='{"content": "'"$message"'"}'
  curl -H "Content-Type: application/json" -d "$discord_payload" "$discord_webhook_url"
}

# Create backup directory if it doesn't exist
mkdir -p "$backup_dir"

# Generate backup filename with timestamp
backup_terraform_file="terraform_$(date +%Y%m%d_%H%M%S).sql"
backup_auth_real_file="authelia_real_$(date +%Y%m%d_%H%M%S).sql"
backup_auth_test_file="authelia_test_$(date +%Y%m%d_%H%M%S).sql"
backup_dbdump_file="dbdump_$(date +%Y%m%d_%H%M%S).sql"

# Perform database backup
docker container exec postgres /usr/bin/pg_dump -U pgad -d "$database_terrafrom" > "$backup_dir/$backup_terraform_file"

# Send discord notification
# Check if backup succeeded or failed
if [ $? -eq 0 ]; then
  echo "PostgreSQL database backup completed successfully."
  send_discord_notification "$database_terrafrom database backup completed successfully."
else
  echo "PostgreSQL database backup failed."
  send_discord_notification "$database_terrafrom database backup failed."
  exit 1
fi

# Perform database backup
docker container exec postgres /usr/bin/pg_dump -U pgad -d "$database_auth_real" > "$backup_dir/$backup_auth_real_file"

# Send discord notification
# Check if backup succeeded or failed
if [ $? -eq 0 ]; then
  echo "PostgreSQL database backup completed successfully."
  send_discord_notification "$database_auth_real database backup completed successfully."
else
  echo "PostgreSQL database backup failed."
  send_discord_notification "$database_auth_real database backup failed."
  exit 1
fi

# Perform database backup
docker container exec postgres /usr/bin/pg_dump -U pgad -d "$database_auth_test" > "$backup_dir/$backup_auth_test_file"

# Send discord notification
# Check if backup succeeded or failed
if [ $? -eq 0 ]; then
  echo "PostgreSQL database backup completed successfully."
  send_discord_notification "$database_auth_test database backup completed successfully."
else
  echo "PostgreSQL database backup failed."
  send_discord_notification "$database_auth_test database backup failed."
  exit 1
fi

# Perform database backup
docker container exec postgres /usr/bin/pg_dumpall -U pgad > "$backup_dir/$backup_dbdump_file"
# Send discord notification
# Check if backup succeeded or failed
if [ $? -eq 0 ]; then
  echo "PostgreSQL database backup completed successfully."
  send_discord_notification "Full database backup completed successfully."
else
  echo "PostgreSQL database backup failed."
  send_discord_notification "Full database backup failed."
  exit 1
fi

# SCP to nas
cp $backup_dir/$backup_terraform_file $nas_dir/$backup_terraform_file && scp $backup_dir/$backup_auth_real_file $nas_dir/$backup_auth_real_file && scp $backup_dir/$backup_auth_test_file $nas_dir/$backup_auth_test_file && scp $backup_dir/$backup_dbdump_file $nas_dir/$backup_dbdump_file

# Send discord notification
# Check if backup succeeded or failed
if [ $? -eq 0 ]; then
  echo "All PostgreSQL databases copied to NAS completed successfully."
  send_discord_notification "All PostgreSQL databases copied to NAS completed successfully."
else
  echo "PostgreSQL database copy to NAS failed."
  send_discord_notification "PostgreSQL database copy to NAS failed."
  exit 1
fi

# Delete backups older than the retention period
find "$backup_dir" -name "*.sql" -type f -mtime +"$retention_period" -delete
find "$nas_dir" -name "*.sql" -type f -mtime +"$retention_period" -delete

send_discord_notification "Deleted database backup older than  30 days"
