#!/usr/bin/env ruby

$stdout.sync = true

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))

config_option = 'autobackup'

# make sure config file allows backing up
if `#{PROGRAM_LOCATION}/configreader.rb find #{config_option}`.strip! == 'false'
  puts "Configuration has [ #{config_option} ] set to 'false'"
  puts "exiting..."
  exit
end

backups_location = Dir.new(File.expand_path("#{PROGRAM_LOCATION}/../backups"))

# leave off ".", "..", and ".gitkeep" from the array of backup files
backups = backups_location.entries.grep(/\.zip/)

# sorting by filename,
# so as long as filename has
# the date in it, we should be fine
backups.sort!

removed = 0
while (backups.size > 30) do
  puts "REMOVING " + backups[0]
  File.delete("#{backups_location.path}/#{backups[0]}")
  backups.shift # yank the first element from the array
  removed += 1
end

puts "#{removed} backups removed"
