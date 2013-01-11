#!/usr/bin/env ruby

PROGRAM_NAME = File.basename(__FILE__)
PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))

PROPERTIES_FILE = "#{PROGRAM_LOCATION}/../lib/server.properties"

def help str
  puts str if str
  puts
  puts "USAGE: #{PROGRAM_NAME} list|(find <property>)"
  puts
  exit 1
end

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
  properties.each {|k, v| puts "#{k}: #{v}"}
when "find"
  key = ARGV.shift
  help("no property given") if key.nil?
  if properties.include?(key)
    puts properties[key]
  else
    help("property [ #{key} ] not found")
  end
when nil
  help("no command given")
else
  help("unknown command [ #{command} ]")
end
