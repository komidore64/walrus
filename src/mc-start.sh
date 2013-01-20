#!/bin/bash

SCRIPT_LOCATION="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # bash hack to get the location of this script

CRAFTBUKKIT_LOCATION=$SCRIPT_LOCATION/../lib/

$SCRIPT_LOCATION/craftbukkitupdate.rb

MAX_MEM=$( $SCRIPT_LOCATION/readconfig.rb find craftbukkit_maximum_memory )
MIN_MEM=$( $SCRIPT_LOCATION/readconfig.rb find craftbukkit_minimum_memory )

pushd $CRAFTBUKKIT_LOCATION > /dev/null 2>&1
java -Xmx"$MAX_MEM"M -Xms"$MIN_MEM"M -jar $( find . -name craftbukkit*.jar ) nogui --nojline
