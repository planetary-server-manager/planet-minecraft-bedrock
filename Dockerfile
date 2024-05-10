FROM ubuntu:latest

LABEL maintainer="thekraken8him"

ENV TIMEZONE=America/Los_Angeles \
    PUID=0 \
    PGID=0

EXPOSE 19132-19133/udp

RUN apt-get update
RUN apt-get install software-properties-common apt-transport-https curl unzip -y

RUN mkdir /server

# Download bedrock-server
RUN curl https://minecraft.azureedge.net/bin-linux/bedrock-server-1.20.81.01.zip -o /server/bedrock-server-1.20.81.01.zip
RUN unzip /server/bedrock-server-1.20.81.01.zip -d /server

COPY server.sh server.sh

RUN chmod +x server.sh
RUN chmod +x /server/bedrock_server

CMD ["/bin/bash", "server.sh"]