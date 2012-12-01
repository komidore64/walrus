#!/bin/bash

WORLDLOCATION=/home/minecraft/srv/
WORLDNAME=world1
BACKUPSLOCATION=/home/minecraft/backups/

# force-save the world
echo -n "force-saving minecraft world..."
/home/minecraft/force-save.sh;
sleep 10;
echo "DONE"

# back up the world
echo -n "backing up minecraft world..."
cd $WORLDLOCATION;
zip -r $BACKUPSLOCATION$WORLDNAME\_`date +%F_%T`.zip $WORLDNAME
echo "DONE"
