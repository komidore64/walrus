#!/bin/bash

crafty_log=/home/minecraft/craftbukkit-update.log

echo -n "$(date +%c) - checking for latest craftbukkit jar..." | tee -a $crafty_log

# permanent craftbukkit download link
download_link="http://dl.bukkit.org/downloads/craftbukkit/get/latest-rb/craftbukkit.jar"

# get the direct download link to the current craftbukkit jar
direct_jar_link=$(curl -is $download_link | grep Location | cut -d' ' -f2 | tr -d [[:space:]])

# get the jar name from the download link
new_jar_name=$(echo "$direct_jar_link" | awk -F/ '{print $NF}')

# move to server directory
cd ~/srv/

# download the latest craftbukkit jar
wget --quiet -O new-bukkit.jar $direct_jar_link

old_jar_name=$(find . -name craftbukkit*.jar)

if (cmp --quiet $old_jar_name new-bukkit.jar) then
    echo "UP TO DATE" | tee -a $crafty_log
    rm -f new-bukkit.jar
else
    echo -n "UPDATING to $new_jar_name..." | tee -a $crafty_log
    rm old-jars/*
    mv $old_jar_name old-jars/

    mv new-bukkit.jar $new_jar_name
    echo "DONE" | tee -a $crafty_log
fi
