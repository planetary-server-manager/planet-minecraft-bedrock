FROM ubuntu:latest

LABEL maintainer="thekraken8him"

ENV TIMEZONE=America/Los_Angeles \
    PUID=1000 \
    PGID=1000 \
    SERVER_NAME="Jellie Frontier Server" \
    WORLD_NAME="jellie-frontier" \
    WORLD_SEED= \
    AUTO_UPDATE=true \
    BACKUPS=false \
    GAMEMODE="survival" \
    FORCE_GAMEMODE=false \
    DIFFICULTY="easy" \
    ALLOW_CHEATS=false \
    MAX_PLAYERS=10 \
    CHAT_RESTRICTION="None" \
    ONLINE_MODE=true \
    ALLOW_LIST=false \
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

RUN apt-get update
RUN apt-get install software-properties-common apt-transport-https curl unzip -y

RUN usermod -l minecraft ubuntu
RUN mkdir /prep && chown -R minecraft /prep

COPY update.sh update.sh
COPY server.sh server.sh
COPY bootstrap.sh bootstrap.sh
COPY backup-map.sh backup-map.sh
COPY backup-pause.sh backup-pause.sh

RUN chmod 770 update.sh && chown minecraft update.sh
RUN chmod 770 server.sh && chown minecraft server.sh
RUN chmod 770 bootstrap.sh && chown minecraft bootstrap.sh
RUN chmod 770 backup-map.sh && chown minecraft backup-map.sh
RUN chmod 770 backup-pause.sh && chown minecraft backup-pause.sh

CMD ["/bin/bash", "bootstrap.sh"]