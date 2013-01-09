#!/bin/bash
craftbukkit_location=../lib/

~/craftbukkitupdate.rb

pushd $craftbukkit_location;
java -Xmx4G -Xms2G -jar $(find . -name craftbukkit*.jar) nogui --nojline
