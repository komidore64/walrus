#!/usr/bin/env ruby

require 'yaml'

PROGRAM_NAME = File.basename($PROGRAM_NAME)

PROGRAM_LOCATION = File.dirname(__FILE__)

command = ARGV.shift

config = YAML.load(File.open("#{PROGRAM_LOCATION}/../config/walrus.yml"))

case command
when 'list'
  config.each {|k,v| puts "#{k}: #{v}"}
when 'find'
  property = ARGV.shift
  if config.include?(property)
    puts config[property]
  else
    puts "property not found"
  end
else
  puts "unknown command"
  puts
  puts "USAGE: #{PROGRAM_NAME} list|(find <property>)"
  puts
end
