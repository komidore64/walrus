#! /bin/bash
### BEGIN INIT INFO
# Provides: minecraft
# Required-Start: $local_fs $remote_fs
# Required-Stop: $local_fs $remote_fs
# Default-Start: 5
# Default-Stop:
# Short-Description: CraftBukkit Game Server
# Description: Starts CraftBukkit Game Server on machine boot
# Author: komidore64@gmail.com
### END INIT INFO

su komidore64 -c '(cd ~/minecraft/; ./start.sh;)'
