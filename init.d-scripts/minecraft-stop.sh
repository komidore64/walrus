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

SCRIPT_LOCATION="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # bash hack to get the location of this script
SOURCE_LOCATION=$SCRIPT_LOCATION/../src

USER=$( $SOURCE_LOCATION/readconfig.rb find walrus_user )

su $USER -c "(cd $SOURCE_LOCATION; ./close-nicely.sh;)"
