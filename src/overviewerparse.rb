#!/usr/bin/env ruby

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))
OVERVIEWER = "#{PROGRAM_LOCATION}/../overviewer/overviewer.py"
WORLD_NAME = `#{PROGRAM_LOCATION}/readproperties.rb find level-name`.strip!
WORLD_LOCATION = "#{PROGRAM_LOCATION}/../lib"
TEMP_WORLD_DIR = `#{PROGRAM_LOCATION}/readconfig.rb find overviewer_temporary_dir`.strip!
OUTPUT_DIR = `#{PROGRAM_LOCATION}/readconfig.rb find overviewer_output_dir`.strip!
OVERVIEWER_LOG = "#{PROGRAM_LOCATION}/../log/overviewer.log"

system("#{PROGRAM_LOCATION}/forcesave.rb")

# TODO
#FileUtils.cp_r(
