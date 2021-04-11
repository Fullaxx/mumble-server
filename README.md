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
Set the welcome text the clients will see when connecting
```
-e "WELCOMETEXT=Mumble Server Hosted by example.com"
```
Set a password for the server
```
-e 'PASSWORD=P@$$w0rd!#'
```
Set the bandwidth per client
```
-e BANDWIDTH=56000
```
Set a timeout for clients
```
-e TIMEOUT=10
```
Limit the total number of users that can be connected
```
-e USERS=50
```
Limit the number of users in any channel
```
-e USERSPERCHANNEL=20
```
Set the opus threshhold
```
-e OPUSTHRESHOLD=0
```

## Volume Options
Save your mumble-server.sqlite in /data
```
-v /srv/docker/mumble-server/data:/data
```

## Run the image
Run the image
```
docker run -d \
-e "WELCOMETEXT=Mumble Server Hosted by example.com" \
-e "OPUSTHRESHOLD=0" \
-p 172.17.0.1:64738:64738/tcp \
-p 172.17.0.1:64738:64738/udp \
-v /srv/docker/mumble-server/data:/data \
fullaxx/mumble-server
```
