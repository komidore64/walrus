#!/bin/bash
craftbukkit_location=/home/minecraft/srv/

~/craftbukkit-update.sh

cd $craftbukkit_location;
java -Xmx4G -Xms2G -jar $(find . -name craftbukkit*.jar) nogui
