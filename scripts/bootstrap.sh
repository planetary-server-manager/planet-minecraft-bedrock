#!/bin/bash
cd /scripts
ls -l && \
if $AUTO_UPDATE ; then
    ./update.sh
else
    echo "Auto-updates disabled. Skipping."
fi && \
if $BACKUPS ; then
    ./backup-map.sh
else
    echo "Backups disabled. Skipping."
fi && \
./update-properties.sh && \
./allowlist.sh && \
./server.sh