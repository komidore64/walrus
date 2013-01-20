#!/usr/bin/env ruby

$stdout.sync = true

SAVE_MESSAGE = "screen -p 0 -S minecraft -X stuff $'say SERVER GOING DOWN IN 10 SECONDS\n'"
FORCE_SAVE = "./forcesave.rb"
CLOSE_COMMAND = "screen -p 0 -S minecraft -X stuff $'stop\n'"
RUNNING_CHECK = "screen -ls | grep --quiet minecraft"

running = system(RUNNING_CHECK)

unless running
  puts "there is no minecraft server running"
  exit 1
end

unless system(SAVE_MESSAGE)
  raise RuntimeError, "unable to send save-message to minecraft server"
end

unless system(FORCE_SAVE)
  raise RuntimeError, "unable to force-save the minecraft world"
end

print "sending shutdown command..."
unless system(CLOSE_COMMAND)
  raise RuntimeError, "unable to send the stop command to the minecraft server"
end
puts "DONE"
