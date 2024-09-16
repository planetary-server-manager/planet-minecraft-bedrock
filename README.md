# Minecraft Bedrock Dedicated Server
Containerized Minecraft Bedrock server for easy portability, deployment, and configuration.

# Summary
This is an all-in one container for running a Minecraft Bedrock server.

# Auto Updates
Automatic updates are turned **on** by default. This will ensure the container always downloads the latest server version every time it starts. If you would like to stay on your current version and disable auto updates, set **AUTO_UPDATE** to **false**.

> **Note**: **AUTO_UPDATE** must be set to **true** for the first run of the container, otherwise no server will be downloaded.

# World Backups
### Enable Backups
Automatic backups are turned **off** by default. To utilize automatic backups, you will need to do the following:
* Set the **BACKUPS** environment variable to **true**.
* Map the **/world-backups** volume to your host.

If you would rather do your own backups manually, your (live) world is contained in the **/server/worlds** folder. I **highly** recommend utilizing the "save" commands described in **/server/bedrock_server_how_to.html** to avoid world corruption.

### How Backups Work
If **BACKUPS** is set to **true**, then each time the container is run, it will automatically create a backup of your **WORLD_NAME** in the **/world-backups** folder. Each backup will be appended with the date and time (%Y-%m-%d_%H-%M-%S format). 

> **Example**: If your world is called **"jellie-frontier"**, and the map is saved on January 2nd, 2024 at exactly 3:45am, the backup will be called **"jellie-frontier-20204-01-02_03-45-00"**.

# Volumes
> :warning: **Important**: It is highly recommended that you map these volumes to your host machine. Otherwise all save data and configuration will be lost when the container is deleted/updated.

| Path | Description |
| --- | --- |
| /server | This contains all your server files including configuration, worlds, and the server binary itself. |
| /world-backups | This contains all world backups (if they are enabled). See [World Backups](#world-backups) for more information. |

# Environment Variables
These environment variables map directly to the settings in the **server.properties** file.

| Variable | Possible Values | Default Value | When it is used | Notes | 
| --- | --- | --- | --- | --- |
| SERVER_NAME | Any string (no semicolon allowed) | Jellie Frontier Server | Always | This is the server name shown in the in-game server list. |
| WORLD_NAME | Any string | jellie-frontier | Always | The name of level to be used/generated. Each level has its own folder in **/worlds**. |
| WORLD_SEED | Any string |   | World creation | The seed to be used for randomizing the world. If left empty a seed will be chosen at random. |
| AUTO_UPDATE | true, false | true | When container (re)starts | Setting this to **false** will disable auto updates and the server will stay on the current version. See [Auto Updates](#auto-updates). |
| BACKUPS | true, false | false | When container (re)starts | Setting this value to **true** will enable automatic world backups every time the container (re)starts in the **/world-backups** folder. See [World Backups](#world-backups) for more information. |
| GAMEMODE | survival, creative, adventure | survival | Always or only for new players |   | 
| FORCE_GAMEMODE | true, false | false | Always | **force-gamemode=false**(or force-gamemode is not defined in the server.properties file) prevents the server from sending to the client gamemode values other than the gamemode value saved by the server during world creation even if those values are set in server.properties file after world creation. <br> **force-gamemode=true** forces the server to send to the client gamemode values other than the gamemode value saved by the server during world creation if those values are set in server.properties file after world creation. |
| DIFFICULTY | peaceful, easy, normal, hard | easy | Always |   |
| ALLOW_CHEATS | true, false | false | Always | If true then cheat-like commands can be used. |
| MAX_PLAYERS | Any integer | 10 | Always | The maximum numbers of players that should be able to play on the server. **Higher values have performance impact.** |
| CHAT_RESTRICTION | None, Dropped, Disabled | None | Always | This represents the level of restriction applied to the chat for each player that joins the server. **"None"** is the default and represents regular free chat. **"Dropped"** means the chat messages are dropped and never sent to any client. Players receive a message to let them know the feature is disabled. **"Disabled"** means that unless the player is an operator, the chat UI does not even appear. No information is displayed to the player. |
| ONLINE_MODE | true, false | true | Always |  	If true, all connected players must be authenticated with Xbox Live. Clients connecting to remote (non-LAN) servers will always require Xbox Live authentication regardless of this setting. If the server accepts connections from the Internet, then it is **highly** recommended to enable online-mode. |
| ALLOW_LIST | true, false | false | Always | If true then all connected players must be listed in the separate **allowlist.json** file. |
| ENABLE_LAN_VISIBILITY | true, false | true | Always | Listen and respond to clients that are looking for servers on the LAN. This will cause the server to bind to the default ports (19132, 19133) even when 'server-port' and 'server-portv6' have non-default values. Consider turning this off if LAN discovery is not desirable, or when running multiple servers on the same host may lead to port conflicts. |
| VIEW_DISTANCE | Any integer greater than 5 | 32 | Always | The maximum allowed view distance. **Higher values have performance impact.** |
| TICK_DISTANCE | An integer in the range [4, 12] | 4 | Always | The world will be ticked this many chunks away from any player. **Higher values have performance impact.** |
| PLAYER_IDLE_TIMEOUT | Any positive integer, including 0 | 30 | Always | After a player has idled for this many minutes they will be kicked. If set to 0 then players can idle indefinitely. |
| MAX_THREADS | Any integer | 0 | Always | Maximum number of threads the server will try to use. If set to 0 or removed then it will use as many as possible. |
| DEFAULT_PLAYER_PERMISSION_LEVEL | visitor, member, operator | member | Always | Which permission level new players will have when they join for the first time. |
| DISABLE_PLAYER_INTERACTION | true, false | false | Always | If true, the server will inform clients that they should ignore other players when interacting with the world. This is not server authoritative. |
| TEXTUREPACK_REQUIRED | true, false | false | Always | If the world uses any specific texture packs then this setting will force the client to use it. |
| CONTENT_LOG_FILE_ENABLED | true, false | false | Always | Enables logging content errors to a file. |
| COMPRESSION_THRESHOLD | An integer in the range [0-65535] | 1 | Always | Determines the smallest size of raw network payload to compress. Can be used to experiment with CPU-bandwidth tradeoffs. |
| COMPRESSION_ALGORITHM | zlib, snappy | zlib | Always | Determines the compression algorithm to use for networking. |
| SERVER_AUTHORITATIVE_MOVEMENT | client-auth, server-auth, server-auth-with-rewind | server-auth | Always | Changes the server authority on movement: <br> **"client-auth"**: Server has no authority and accepts all positions from the client. <br> **"server-auth"**: Server takes user input and simulates the Player movement but accepts the Client version if there is disagreement. <br> **"server-auth-with-rewind"**: The server will replay local user input and will push it to the Client so it can correct the position if it does not match. The clients will rewind time back to the correction time, apply the correction, then replay all the player's inputs since then. This results in smoother and more frequent corrections. |
| PLAYER_POSITION_ACCEPTANCE_THRESHOLD | Any positive float | 0.5 | With "server-auth-with-rewind" | Only used with **"server-auth-with-rewind"**. This is the tolerance of discrepancies between the Client and Server Player position. This helps in problematic scenarios. The higher the number, the more tolerant the server will be before asking for a correction. Passed value of 1.0, the chance of missing cheating increases. |
| PLAYER_MOVEMENT_ACTION_DIRECTION_THRESHOLD | Any positive float in the range of [-1.00, 1.00] | 0.85 | Always | The amount that the direction the player is attacking can differ from the direction the player is looking as cos(x) where x is the angle between the two vectors. A value of 1 means the two vectors must be parallel, 0 means anything in front of the player, and -1 means any vector. |
| SERVER_AUTHORITATIVE_BLOCK_BREAKING | true, false | false | Not when client-auth | If true, the server will compute block mining operations in sync with the client so it can verify that the client should be able to break blocks when it thinks it can. This setting cannot be combined with client authoritative movement and will be disabled if that setting is enabled. |
| SERVER_AUTHORITATIVE_BLOCK_BREAKING_PICK_RANGE_SCALAR | Any float above 1.0 | 1.5 | When **SERVER_AUTHORITATIVE_BLOCK_BREAKING** is **true** | This increase the range of block breaking. This is squared and multiplied with the default range. |
| CLIENT_SIDE_CHUNK_GENERATION_ENABLED | true, false | true | Always | If true, the server will inform clients that they have the ability to generate visual level chunks outside of player interaction distances. |
| BLOCK_NETWORK_IDS_ARE_HASHES | true, false | true | Always | If true, the server will send hashed block network ID's instead of id's that start from 0 and go up. These id's are stable and won't change regardless of other block changes. |
| DISABLE_CUSTOM_SKINS | true, false | false | Always | If true, disable players customized skins that were customized outside of the Minecraft store assets or in game assets. This is used to disable possibly offensive custom skins players make. |
| SERVER_BUILD_RADIUS_RATIO | Disabled, 0.0-1.0 | Disabled | Always | If "Disabled" the server will dynamically calculate how much of the player's view it will generate, assigning the rest to the client to build. Otherwise from the overridden ratio tell the server how much of the player's view to generate, disregarding client hardware capability. **Only valid if client-side-chunk-generation-enabled is enabled.** |
| ALLOW_OUTBOUND_SCRIPT_DEBUGGING | true, false | false | Always | Allows script debugger 'connect' command and script-debugger-auto-attach=connect mode. | 
| ALLOW_INBOUND_SCRIPT_DEBUGGING | true, false | false | Always | Allows script debugger 'listen' command and script-debugger-auto-attach=listen mode. |
| SCRIPT_DEBUGGER_AUTO_ATTACH | disabled, connect, listen | disabled | Always | Attempt to attach script debugger at level load, requires that either inbound port or connect address is set and that inbound or outbound connections are enabled. <br> **"disabled"** will not auto attach. <br> **"connect"** server will attempt to connect to debugger in listening mode on the specified port. <br> **"listen"** server will listen to inbound connect attempts from debugger using connect mode on the specified port. |
| TELEMETRY | true, false | false | Always | Setting to **true** will send server telemetry data to Microsoft. It's unclear exactly what telemetry is collected, but it's likely similar to [Java Edition's telemetry](https://minecraft.wiki/w/Telemetry#Telemetry_Data_Collection). |