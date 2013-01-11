#!/bin/bash

SCRIPT_LOCATION="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # bash hack to get the location of this script

pushd $SCRIPT_LOCATION > /dev/null 2>&1

CRAFTBUKKIT_RUNNING=$( screen -ls | grep minecraft )
if [ -n "$CRAFTBUKKIT_RUNNING" ]; then
    echo "craftbukkit is already running"
else
    echo "starting craftbukkit server"
    screen -AdmS minecraft ./mc-start.sh
fi
