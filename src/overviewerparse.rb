#!/usr/bin/env ruby

# TODO
# - figure out which worlds are enabled/disabled from bukkit.yml and server.properies
# - render all enabled worlds in one swoop
# - utilized overviewer's configfile options

$stdout.sync = true

require 'fileutils'

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))
OVERVIEWER = "#{PROGRAM_LOCATION}/../overviewer/overviewer.py"
WORLD_NAME = `#{PROGRAM_LOCATION}/readproperties.rb find level-name`.strip!
WORLD_LOCATION = "#{PROGRAM_LOCATION}/../lib"
TEMP_WORLD_DIR = `#{PROGRAM_LOCATION}/readconfig.rb find overviewer_temporary_dir`.strip!
OUTPUT_DIR = `#{PROGRAM_LOCATION}/readconfig.rb find overviewer_output_dir`.strip!

system("#{PROGRAM_LOCATION}/forcesave.rb")


# copy the worlds to a temporary location
FileUtils.mkdir(TEMP_WORLD_DIR) unless File.exists?(TEMP_WORLD_DIR)
FileUtils.cp_r("#{WORLD_LOCATION}/#{WORLD_NAME}", TEMP_WORLD_DIR, :preserve => true)

# render the worlds into the output directory
FileUtils.mkdir(OUTPUT_DIR) unless File.exists?(OUTPUT_DIR)
system("python #{OVERVIEWER} #{TEMP_WORLD_DIR}/#{WORLD_NAME} #{OUTPUT_DIR}")

FileUtils.rm_r(TEMP_WORLD_DIR)
