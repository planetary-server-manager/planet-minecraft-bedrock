FROM ghcr.io/planetary-server-manager/planetary-base:latest

LABEL maintainer="thekraken8him"

ENV SERVER_NAME="Planetary Minecraft Server" \
    WORLD_NAME="planetary-minecraft" \
    WORLD_SEED= \
    GAMEMODE="survival" \
    FORCE_GAMEMODE=false \
    DIFFICULTY="easy" \
    ALLOW_CHEATS=false \
    CHAT_RESTRICTION="None" \
    ONLINE_MODE=true \
    ENABLE_LAN_VISIBILITY=true \
    VIEW_DISTANCE=32 \
    TICK_DISTANCE=4 \
    PLAYER_IDLE_TIMEOUT=30 \
    MAX_THREADS=0 \
    DEFAULT_PLAYER_PERMISSION_LEVEL=member \
    DISABLE_PLAYER_INTERACTION=false \
    TEXTUREPACK_REQUIRED=false \
    CONTENT_LOG_FILE_ENABLED=false \
    COMPRESSION_THRESHOLD=1 \
    COMPRESSION_ALGORITHM="zlib" \
    SERVER_AUTHORITATIVE_MOVEMENT="server-auth" \
    PLAYER_POSITION_ACCEPTANCE_THRESHOLD=0.5 \
    PLAYER_MOVEMENT_ACTION_DIRECTION_THRESHOLD=0.85 \
    SERVER_AUTHORITATIVE_BLOCK_BREAKING=false \
    SERVER_AUTHORITATIVE_BLOCK_BREAKING_PICK_RANGE_SCALAR=1.5 \
    CLIENT_SIDE_CHUNK_GENERATION_ENABLED=true \
    BLOCK_NETWORK_IDS_ARE_HASHES=true \
    DISABLE_CUSTOM_SKINS=false \
    SERVER_BUILD_RADIUS_RATIO="Disabled" \
    ALLOW_OUTBOUND_SCRIPT_DEBUGGING=false \
    ALLOW_INBOUND_SCRIPT_DEBUGGING=false \
    SCRIPT_DEBUGGER_AUTO_ATTACH="disabled" \
    TELEMETRY=false

EXPOSE 19132-19133/udp

RUN usermod -l minecraft ubuntu

COPY /scripts /scripts

RUN chmod -R 770 /scripts && chown -R minecraft /scripts

USER minecraft

CMD ["/bin/bash", "/scripts/bootstrap.sh"]