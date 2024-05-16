#!/bin/bash
if [ "$BACKUPS" = true ] ; then
    BACKUP_INTERVAL_SECONDS=$((BACKUP_INTERVAL * 3600))
    ./server.exp $BACKUP_INTERVAL_SECONDS
else
    ./server.sh
fi