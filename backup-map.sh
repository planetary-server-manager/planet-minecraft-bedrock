#!/bin/bash
echo "Copying Files..."
timestamp=$(date +%Y-%m-%d_%H:%M:%S)
ls / | grep world-backups && \
cp -r "/server/worlds/$WORLD_NAME" "/world-backups/$WORLD_NAME-$timestamp" && \
echo "Done." || \
mkdir /world-backups && \
cp -r "/server/worlds/$WORLD_NAME" "/world-backups/$WORLD_NAME-$timestamp" && \
echo "Done."