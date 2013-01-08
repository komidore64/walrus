#!/usr/bin/env ruby

def help str
  puts str if str
  puts
  puts "Usage: readproperties.rb (list|find <key>)"
  puts
  exit 1
end

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))
PROPERTIES_FILE = File.expand_path([PROGRAM_LOCATION, "..", "lib", "server.properties"].join('/'))

properties = {}

File.open(PROPERTIES_FILE, "r") do |file|
  file.read.split("\n").each do |l|
    l.strip!
    key, value = l.split("=")
    properties[key] = value
  end
end

command = ARGV.shift

case command
when "list"
  properties.each do |k, v|
    puts "#{k}: #{v}"
  end
when "find"
  search_key = ARGV.shift
  help("No key to look for") if search_key.nil?
  puts properties[search_key]
else
  help("No command given")
end
