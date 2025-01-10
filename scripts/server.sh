#!/bin/bash
# Copy files to /server if it's empty
ls /server/server.properties && cd /server && mv /prep/bedrock_server /server/bedrock_server || cp -RT /prep/ /server/ && cd /server && \
# Configure server properties
sed -i "s/server-name=.*/server-name=$SERVER_NAME/g" server.properties
sed -i "s/level-name=.*/level-name=$WORLD_NAME/g" server.properties
sed -i "s/level-seed=.*/level-seed=$WORLD_SEED/g" server.properties
sed -i "s/gamemode=.*/gamemode=$GAMEMODE/g" server.properties
sed -i "s/force-gamemode=.*/force-gamemode=$FORCE_GAMEMODE/g" server.properties
sed -i "s/difficulty=.*/difficulty=$DIFFICULTY/g" server.properties
sed -i "s/allow-cheats=.*/allow-cheats=$ALLOW_CHEATS/g" server.properties
sed -i "s/max-players=.*/max-players=$MAX_PLAYERS/g" server.properties
sed -i "s/chat-restriction=.*/chat-restriction=$CHAT_RESTRICTION/g" server.properties
sed -i "s/online-mode=.*/online-mode=$ONLINE_MODE/g" server.properties
sed -i "s/allow-list=.*/allow-list=$ALLOW_LIST/g" server.properties
sed -i "s/enable-lan-visibility=.*/enable-lan-visibility=$ENABLE_LAN_VISIBILITY/g" server.properties
sed -i "s/view-distance=.*/view-distance=$VIEW_DISTANCE/g" server.properties
sed -i "s/tick-distance=.*/tick-distance=$TICK_DISTANCE/g" server.properties
sed -i "s/player-idle-timeout=.*/player-idle-timeout=$PLAYER_IDLE_TIMEOUT/g" server.properties
sed -i "s/max-threads=.*/max-threads=$MAX_THREADS/g" server.properties
sed -i "s/default-player-permission-level=.*/default-player-permission-level=$DEFAULT_PLAYER_PERMISSION_LEVEL/g" server.properties
sed -i "s/disable-player-interaction=.*/disable-player-interaction=$DISABLE_PLAYER_INTERACTION/g" server.properties
sed -i "s/texturepack-required=.*/texturepack-required=$TEXTUREPACK_REQUIRED/g" server.properties
sed -i "s/content-log-file-enabled=.*/content-log-file-enabled=$CONTENT_LOG_FILE_ENABLED/g" server.properties
sed -i "s/compression-threshold=.*/compression-threshold=$COMPRESSION_THRESHOLD/g" server.properties
sed -i "s/compression-algorithm=.*/compression-algorithm=$COMPRESSION_ALGORITHM/g" server.properties
sed -i "s/server-authoritative-movement=.*/server-authoritative-movement=$SERVER_AUTHORITATIVE_MOVEMENT/g" server.properties
sed -i "s/player-position-acceptance-threshold=.*/player-position-acceptance-threshold=$PLAYER_POSITION_ACCEPTANCE_THRESHOLD/g" server.properties
sed -i "s/player-movement-action-direction-threshold=.*/player-movement-action-direction-threshold=$PLAYER_MOVEMENT_ACTION_DIRECTION_THRESHOLD/g" server.properties
sed -i "s/server-authoritative-block-breaking=.*/server-authoritative-block-breaking=$SERVER_AUTHORITATIVE_BLOCK_BREAKING/g" server.properties
sed -i "s/server-authoritative-block-breaking-pick-range-scalar=.*/server-authoritative-block-breaking-pick-range-scalar=$SERVER_AUTHORITATIVE_BLOCK_BREAKING_PICK_RANGE_SCALAR/g" server.properties
sed -i "s/client-side-chunk-generation-enabled=.*/client-side-chunk-generation-enabled=$CLIENT_SIDE_CHUNK_GENERATION_ENABLED/g" server.properties
sed -i "s/block-network-ids-are-hashes=.*/block-network-ids-are-hashes=$BLOCK_NETWORK_IDS_ARE_HASHES/g" server.properties
sed -i "s/disable-custom-skins=.*/disable-custom-skins=$DISABLE_CUSTOM_SKINS/g" server.properties
sed -i "s/server-build-radius-ratio=.*/server-build-radius-ratio=$SERVER_BUILD_RADIUS_RATIO/g" server.properties
sed -i "s/allow-outbound-script-debugging=.*/allow-outbound-script-debugging=$ALLOW_OUTBOUND_SCRIPT_DEBUGGING/g" server.properties
sed -i "s/allow-inbound-script-debugging=.*/allow-inbound-script-debugging=$ALLOW_INBOUND_SCRIPT_DEBUGGING/g" server.properties
sed -i "s/script-debugger-auto-attach=.*/script-debugger-auto-attach=$SCRIPT_DEBUGGER_AUTO_ATTACH/g" server.properties
# Enable/Disable Telemetry
cat server.properties | grep emit-server-telemetry= && \
sed -i "s/emit-server-telemetry=.*/emit-server-telemetry=$TELEMETRY/g" server.properties || \
echo "emit-server-telemetry=$TELEMETRY" >> server.properties
# Start server
./bedrock_server
