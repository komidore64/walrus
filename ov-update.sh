#!/bin/bash

overviewer=/home/minecraft/ov/overviewer.py
mc_world=/home/minecraft/srv/world1/
temp_world=/tmp/overviewer
web_dir=/var/www/mc/
log=/home/minecraft/ov.log


# force save minecraft world
echo -n "force-saving minecraft world..."
/home/minecraft/force-save.sh

# sleep for 10 seconds to make sure force-save finishes
sleep 10 # probably overkill, but whatever...
echo "DONE";

# delete current world render
rm -rf $web_dir*

# copy world to temp location
cp -r $mc_world $temp_world

# create overviewer from temp location
(python $overviewer $temp_world $web_dir) && (echo `date +%c` >> $log)

# remove temp world location
rm -rf $temp_world
