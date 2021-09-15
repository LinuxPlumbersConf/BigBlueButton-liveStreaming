#!/bin/bash
#
# You must pass exactly 5 parameters:
# $1 - local hostname (i.e. streamer2)
# $2 - target bbb server hostname to stream from (i.e. bbb2)
# $3 - target bbb server secret
# $4 - target bbb meetingID (i.e. "Hackroom 1")
# $5 - YouTube Streaming key to use 
#

cat > docker-compose.yml << EOF
version: '3.3'
services:
  bbb-streamer:
    image: lpc2020streamer
    build: .
    container_name: lpc2020streamercontainer
    environment:
      - BBB_URL=https://$2.lpc.events/bigbluebutton/api
      - BBB_SECRET=$3
      - BBB_MEETING_ID=$4
      - BBB_USER_NAME=YouTube Live
      - BBB_AS_MODERATOR=true
      - BBB_ATTENDEE_PASSWORD=LPCattendee
      - BBB_MODERATOR_PASSWORD=LPCmoderator
      - BBB_STREAM_URL=rtmp://a.rtmp.youtube.com/live2/$5
      - TZ=America/New_York

    volumes:
      - ./videodata:/video
EOF

