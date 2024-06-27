FROM ubuntu:latest

LABEL maintainer="thekraken8him"

ENV TIMEZONE=America/Los_Angeles \
    PUID=1000 \
    PGID=1000 \
    SERVER_NAME="Jellie Frontier Server" \
    WORLD_NAME="jellie-frontier" \
    WORLD_SEED= \
    BACKUPS=false \
    BACKUP_INTERVAL=24 \
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
RUN apt-get install software-properties-common apt-transport-https curl unzip expect -y

RUN usermod -l minecraft ubuntu
RUN mkdir /prep

# Download bedrock-server
RUN curl https://minecraft.azureedge.net/bin-linux/bedrock-server-1.21.1.03.zip -o /prep/bedrock-server-1.21.1.03.zip
RUN unzip /prep/bedrock-server-1.21.1.03.zip -d /prep
RUN rm /prep/bedrock-server-1.21.1.03.zip

COPY server.sh server.sh
COPY server.exp server.exp
COPY bootstrap.sh bootstrap.sh
COPY backup-map.sh backup-map.sh
COPY backup-pause.sh backup-pause.sh

RUN chmod 770 server.sh && chown minecraft server.sh
RUN chmod +x /prep/bedrock_server && chown -R minecraft /prep
RUN chmod 770 server.exp && chown minecraft server.exp
RUN chmod 770 bootstrap.sh && chown minecraft bootstrap.sh
RUN chmod 770 backup-map.sh && chown minecraft backup-map.sh
RUN chmod 770 backup-pause.sh && chown minecraft backup-pause.sh

CMD ["/bin/bash", "bootstrap.sh"]