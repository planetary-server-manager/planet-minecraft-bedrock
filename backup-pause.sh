BACKUP_INTERVAL_SECONDS=$((BACKUP_INTERVAL * 3600))
echo "Next save will be in $BACKUP_INTERVAL hour(s)."
sleep $BACKUP_INTERVAL_SECONDS
echo "Starting backup..."