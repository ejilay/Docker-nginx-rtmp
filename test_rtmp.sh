#!/bin/sh
set -x

SIZE=384x216
#SIZE=1280x720

ffmpeg  -hide_banner -re -f lavfi -i "testsrc=s=${SIZE}" -f lavfi -i "sine=frequency=217:sample_rate=44100"  -vcodec libx264 -pix_fmt yuv420p -bsf:v h264_mp4toannexb -vf fps=30 -acodec aac -ar 44100 -f flv rtmp://127.0.0.1:1935/streams/test

