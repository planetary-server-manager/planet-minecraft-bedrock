#!/bin/bash
# Copy files to /server if it's empty
ls /server/server.properties && cd /server || cp -RT /prep/ /server/ && rm -R /prep && cd /server && \
# Configure server properties
sed -i "s/server-name=Dedicated Server/server-name=$SERVER_NAME/g" server.properties
sed -i "s/level-name=Bedrock level/level-name=$WORLD_NAME/g" server.properties
sed -i "s/level-seed=/level-seed=$WORLD_SEED/g" server.properties
sed -i "s/gamemode=survival/gamemode=$GAMEMODE/g" server.properties
sed -i "s/force-gamemode=false/force-gamemode=$FORCE_GAMEMODE/g" server.properties
sed -i "s/difficulty=easy/difficulty=$DIFFICULTY/g" server.properties
sed -i "s/allow-cheats=false/allow-cheats=$ALLOW_CHEATS/g" server.properties
sed -i "s/max-players=10/max-players=$MAX_PLAYERS/g" server.properties
sed -i "s/chat-restriction=None/chat-restriction=$CHAT_RESTRICTION/g" server.properties
sed -i "s/online-mode=true/online-mode=$ONLINE_MODE/g" server.properties
sed -i "s/allow-list=false/allow-list=$ALLOW_LIST/g" server.properties
sed -i "s/enable-lan-visibility=true/enable-lan-visibility=$ENABLE_LAN_VISIBILITY/g" server.properties
sed -i "s/view-distance=32/view-distance=$VIEW_DISTANCE/g" server.properties
sed -i "s/tick-distance=4/tick-distance=$TICK_DISTANCE/g" server.properties
sed -i "s/player-idle-timeout=30/player-idle-timeout=$PLAYER_IDLE_TIMEOUT/g" server.properties
sed -i "s/max-threads=8/max-threads=$MAX_THREADS/g" server.properties
sed -i "s/default-player-permission-level=member/default-player-permission-level=$DEFAULT_PLAYER_PERMISSION_LEVEL/g" server.properties
sed -i "s/disable-player-interaction=false/disable-player-interaction=$DISABLE_PLAYER_INTERACTION/g" server.properties
sed -i "s/texturepack-required=false/texturepack-required=$TEXTUREPACK_REQUIRED/g" server.properties
sed -i "s/content-log-file-enabled=false/content-log-file-enabled=$CONTENT_LOG_FILE_ENABLED/g" server.properties
sed -i "s/compression-threshold=1/compression-threshold=$COMPRESSION_THRESHOLD/g" server.properties
sed -i "s/compression-algorithm=zlib/compression-algorithm=$COMPRESSION_ALGORITHM/g" server.properties
sed -i "s/server-authoritative-movement=server-auth/server-authoritative-movement=$SERVER_AUTHORITATIVE_MOVEMENT/g" server.properties
sed -i "s/player-position-acceptance-threshold=0.5/player-position-acceptance-threshold=$PLAYER_POSITION_ACCEPTANCE_THRESHOLD/g" server.properties
sed -i "s/player-movement-action-direction-threshold=0.85/player-movement-action-direction-threshold=$PLAYER_MOVEMENT_ACTION_DIRECTION_THRESHOLD/g" server.properties
sed -i "s/server-authoritative-block-breaking=false/server-authoritative-block-breaking=$SERVER_AUTHORITATIVE_BLOCK_BREAKING/g" server.properties
sed -i "s/server-authoritative-block-breaking-pick-range-scalar=1.5/server-authoritative-block-breaking-pick-range-scalar=$SERVER_AUTHORITATIVE_BLOCK_BREAKING_PICK_RANGE_SCALAR/g" server.properties
sed -i "s/client-side-chunk-generation-enabled=true/client-side-chunk-generation-enabled=$CLIENT_SIDE_CHUNK_GENERATION_ENABLED/g" server.properties
sed -i "s/block-network-ids-are-hashes=true/block-network-ids-are-hashes=$BLOCK_NETWORK_IDS_ARE_HASHES/g" server.properties
sed -i "s/disable-custom-skins=false/disable-custom-skins=$DISABLE_CUSTOM_SKINS/g" server.properties
sed -i "s/server-build-radius-ratio=Disabled/server-build-radius-ratio=$SERVER_BUILD_RADIUS_RATIO/g" server.properties
sed -i "s/allow-outbound-script-debugging=false/allow-outbound-script-debugging=$ALLOW_OUTBOUND_SCRIPT_DEBUGGING/g" server.properties
sed -i "s/allow-inbound-script-debugging=false/allow-inbound-script-debugging=$ALLOW_INBOUND_SCRIPT_DEBUGGING/g" server.properties
sed -i "s/script-debugger-auto-attach=disabled/script-debugger-auto-attach=$SCRIPT_DEBUGGER_AUTO_ATTACH/g" server.properties
# Enable/Disable Telemetry
cat server.properties | grep emit-server-telemetry= && \
sed -i "s/emit-server-telemetry=.*/emit-server-telemetry=$TELEMETRY/g" server.properties || \
echo "emit-server-telemetry=$TELEMETRY" >> server.properties
# Start server
./bedrock_server
