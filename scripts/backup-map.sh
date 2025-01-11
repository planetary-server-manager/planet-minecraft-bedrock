#!/bin/bash
echo "Backing up map files..." && \
timestamp=$(date +%Y-%m-%d_%H-%M-%S) && \
cp -r "/server/worlds/$WORLD_NAME" "/backups/$WORLD_NAME-$timestamp" && \
echo "Done." || \
echo "No map found, skipping backup. This is expected if this is the first run of the server."