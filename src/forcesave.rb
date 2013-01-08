#!/usr/bin/env ruby

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))
WORLD_NAME = `#{PROGRAM_LOCATION}/readproperties.rb find level-name`

SAVE_COMMAND = "screen -p 0 -S minecraft -X stuff $'save-all\n'"

print "saving minecraft world..."
raise RuntimeError, "failed to save the minecraft world [ #{WORLD_NAME} ]" unless system(SAVE_COMMAND)
puts "DONE"
