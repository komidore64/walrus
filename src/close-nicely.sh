#!/bin/bash

# notify any logged in players
( screen -p 0 -S minecraft -X stuff $'say SERVER GOING DOWN IN 10 SECONDS\n' ) && \

# force save the world giving it 10 seconds to complete
( ./forcesave.rb 10 ) && \

# pass command to close server cleanly
( screen -p 0 -S minecraft -X stuff $'stop\n ' )
