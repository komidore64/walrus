#!/usr/bin/env ruby

$stdout.sync = true

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))
BACKUPS_LOCATION = File.expand_path("#{PROGRAM_LOCATION}/../backups")

config_option = 'autobackup'

# make sure config file allows backing up
if `#{PROGRAM_LOCATION}/configreader.rb find #{config_option}` == 'false'
  puts "Configuration option [ #{config_option} ] set to 'false'"
  puts "exiting..."
  exit
end

WORLD_NAME = `#{PROGRAM_LOCATION}/readproperties.rb find level-name`.strip!

allow_nether = `#{PROGRAM_LOCATION}./readproperties.rb find allow-nether`.strip! == "true"

# put togther all the world names to add the the zip archive
worlds = "#{WORLD_NAME} #{WORLD_NAME}_the_end"
worlds << " #{WORLD_NAME}_nether" if allow_nether

# force save the world
system("#{PROGRAM_LOCATION}/forcesave.rb")

Dir.chdir(BACKUPS_LOCATION)
output_file = "#{BACKUPS_LOCATION}/#{WORLD_NAME}_#{Time.now.strftime("%F-%T")}.zip"

# back up the world
print "backing up [ #{WORLD_NAME} ] ..."
unless system("zip -r #{output_file} #{worlds}") # don't forget the '-r'!!!
  raise RuntimeError, "failed to back up [ #{WORLD_NAME} ]"
end
puts "DONE"
puts "wrote [ #{output_file} ]"
exit 0
