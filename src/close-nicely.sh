#!/bin/bash
script_dir=/home/minecraft

# notify any logged in players
( screen -p 0 -S minecraft -X stuff $'say SERVER GOING DOWN IN 10 SECONDS\n' ) && \
# force save the world
( $script_dir/force-save.sh ) && \
# sleep for 10 seconds
( sleep 10 ) && \
# pass command to close server cleanly
( screen -p 0 -S minecraft -X stuff $'stop\n ' )
