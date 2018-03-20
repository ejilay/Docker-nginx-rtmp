# Docker-nginx-rtmp
Docker image for an RTMP/HLS server running on nginx

NGINX Version 1.9.10
nginx-rtmp-module Version 1.2.1

### Configurations
This image exposes port 1935 for RTMP Steams and has channel open "streams".

"streams" is also accessable via HLS on port 8080

It also exposes 8080 so you can access http://<your server ip>:8080/stat to see the streaming statistics.

The configuration file is in /opt/nginx/conf/

### Running

To run the container and bind the port 1935 to the host machine; run the following:
```
$ docker run -d --name nginx-rtmp -p 1935:1935 -p 8080:8080 -v `pwd`/hls:/var/www/streams -t ejilay/nginx-rtmp
```

### OBS Configuration
Under broadcast settigns, set the follwing parameters:
```
Streaming Service: Custom
Server: rtmp://<your server ip>:1935/streams
Play Path/Stream Key: mystream
```

### Watching the stream

In your favorite RTMP video player connect to the stream using the URL:
```
rtmp://<your server ip>:1935/streams/mystream
http://<your server ip>:8080/streams/mystream/index.m3u8

rtmp://<your server ip>:1935/streams/mystream2
http://<your server ip>:8080/streams/mystream2/index.m3u8
```

### Tested players
 * VLC
 * omxplayer (Raspberry Pi)
