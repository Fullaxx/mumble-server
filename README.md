# A docker image running mumble-server (murmurd)

## Base Docker Image
[Debian](https://hub.docker.com/_/debian) bullseye (x64)

## Software
[mumble](https://www.mumble.info/) - Open Source, Low Latency, High Quality Voice Chat

## Get the image from Docker Hub or build it locally
```
docker pull fullaxx/mumble-server
docker build -t="fullaxx/mumble-server" github.com/Fullaxx/mumble-server
```

## Configuration Options
Welcome message sent to clients when they connect
```
-e "WELCOMETEXT=Mumble Server Hosted by example.com"
```
Password for unregistered users to join server
```
-e 'PASSWORD=P@$$w0rd!#'
```
Maximum bandwidth (in bits per second) clients are allowed to send speech at
```
-e BANDWIDTH=56000
```
Murmur and Mumble are usually pretty good about cleaning up hung clients \
but occasionally one will get stuck on the server \
The timeout setting will cause a periodic check of all clients \
who haven't communicated with the server in this many seconds \
causing zombie clients to be disconnected
This has no effect on idle clients or people who are AFK \
It will only affect people who are already disconnected \
and just haven't told the server
```
-e TIMEOUT=10
```
Maximum number of concurrent clients allowed
```
-e USERS=50
```
Where users sets a blanket limit on the number of clients per virtual server \
usersperchannel sets a limit on the number per channel \
The default is 0 for no limit.
```
-e USERSPERCHANNEL=20
```
By default murmur exposes the current/maximum user count \
and the server's maximum bandwidth per client to unauthenticated users \
In the Mumble client, this information is shown in the Connect dialog \
Setting ALLOWPING=false will turn off this behavior
```
-e ALLOWPING=false
```
Amount of users with Opus support needed to force Opus usage in percent \
0 = Always enable Opus \
100 = enable Opus if it's supported by all clients
```
-e OPUSTHRESHOLD=0
```
Maximum depth of channel nesting
```
-e CHANNELNESTINGLIMIT=20
```
Maximum number of channels per server \
0 = unlimited
```
-e CHANNELCOUNTLIMIT=500
```
Only clients which have a registered certificate are allowed to connect
```
-e CERTREQUIRED=true
```
If disabled, clients will not be sent information about the server version and OS
```
-e SENDVERSION=false
```
You can set a recommended minimum version for your server \
and clients will be notified in their log when they connect \
if their client does not meet the minimum requirements \
suggestVersion expects the version in the format X.X.X
```
-e SUGGESTVERSION=1.2.4
```

## Volume Options
Save your mumble-server.sqlite in /data
```
-v /srv/docker/mumble-server/data:/data
```

## Run the image
Run the image with unrestricted opus support and suggested version
```
docker run -d \
-e "WELCOMETEXT=Mumble Server Hosted by example.com" \
-e OPUSTHRESHOLD=0 \
-e SUGGESTVERSION=1.2.4 \
-p 172.17.0.1:64738:64738/tcp \
-p 172.17.0.1:64738:64738/udp \
-v /srv/docker/mumble-server/data:/data \
fullaxx/mumble-server
```
