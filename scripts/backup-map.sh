#!/bin/bash
ls /server/worlds/$WORLD_NAME && echo "Backing up map files..." && \
timestamp=$(date +%Y-%m-%d_%H-%M-%S) && \
ls / | grep world-backups && \
cp -r "/server/worlds/$WORLD_NAME" "/world-backups/$WORLD_NAME-$timestamp" && \
echo "Done." || \
mkdir /world-backups && \
cp -r "/server/worlds/$WORLD_NAME" "/world-backups/$WORLD_NAME-$timestamp" && \
echo "Done." || echo "No map found, skipping backup. This is expected if this is the first run of the server."