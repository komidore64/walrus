#!/usr/bin/env ruby

require 'yaml'

PROGRAM_NAME = File.basename(__FILE__)
PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))

def help str
  puts str if str
  puts
  puts "USAGE: #{PROGRAM_NAME} list|(find <property>)"
  puts
  exit 1
end

config = YAML.load(File.open("#{PROGRAM_LOCATION}/../config/walrus.yml"))

command = ARGV.shift

case command
when 'list'
  config.each {|k, v| puts "#{k}: #{v}"}
when 'find'
  property = ARGV.shift
  help("no property given") if property.nil?
  if config.include?(property)
    puts config[property]
  else
    help("property [ #{property} ] not found")
  end
when nil
  help("no command given")
else
  help("unknown command [ #{command} ]")
end
