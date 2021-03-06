#!/usr/bin/env ruby

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))
WORLD_NAME = `#{PROGRAM_LOCATION}/readproperties.rb find level-name`.strip!

if `screen -ls`.split("\n").grep(/minecraft/).empty?
  puts "minecraft server is not running"
  exit
end

SAVE_COMMAND = "screen -p 0 -S minecraft -X stuff $'save-all\n'"

seconds = ARGV.shift.to_i
time = (seconds <= 0) ? 10 : seconds # if argument is not a number or less than zero, just use 10

print "saving [ #{WORLD_NAME} ] to disk ..."
raise RuntimeError, "failed to save the minecraft world [ #{WORLD_NAME} ]" unless system(SAVE_COMMAND)
sleep(time)
puts "DONE"
