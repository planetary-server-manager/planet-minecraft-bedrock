#!/bin/bash
if [ "$BACKUPS" = true ] ; then
    ./server.exp
else
    ./server.sh
fi