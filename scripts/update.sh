#!/bin/bash
echo "Updating server..."
cd /prep && \
SERVER_URL="$(curl 'https://www.minecraft.net/en-us/download/server/bedrock' --compressed -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:130.0) Gecko/20100101 Firefox/130.0' -H 'Accept-Language: en-US,en;q=0.5' | grep -o https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server.*.zip)"
SERVER_ZIP="$(echo "$SERVER_URL" | grep -o bedrock-server.*.zip)"
curl "$SERVER_URL" -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:130.0) Gecko/20100101 Firefox/130.0' -H 'Accept-Language: en-US,en;q=0.5' -o "$SERVER_ZIP" && \
unzip -o $SERVER_ZIP && \
rm $SERVER_ZIP && \
chmod +x /prep/bedrock_server