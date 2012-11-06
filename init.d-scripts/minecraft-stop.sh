#! /bin/bash
### BEGIN INIT INFO
# Provides: minecraft
# Required-Start: $local_fs $remote_fs
# Required-Stop: $local_fs $remote_fs
# Default-Start:
# Default-Stop: 0 6
# Short-Description: CraftBukkit Game Server
# Description: Stops CraftBukkit Game Server on machine shutdown/reboot
# Author: komidore64@gmail.com
### END INIT INFO

su komidore64 -c '(cd ~/minecraft/; ./close-nicely.sh;)'
