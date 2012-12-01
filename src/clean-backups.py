#!/usr/bin/python
import os
from datetime import datetime

backups_location = '/home/minecraft/backups'
backups = os.listdir(backups_location)

# sorts by filename (i think) 
# so as long as filename has 
# the date in it, we should be fine
backups.sort() 

while (len(backups) > 30) :
    print "REMOVING " + backups[0]
    os.remove(backups_location + "/" + backups[0])
    backups.remove(backups[0])
