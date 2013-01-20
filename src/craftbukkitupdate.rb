#!/usr/bin/env ruby

$stdout.sync = true

require 'net/http'

PROGRAM_LOCATION = File.expand_path(File.dirname(__FILE__))

config_option = 'autoupdate_jar'

# check to see if auto-updating is allowed in walrus.yml
if `#{PROGRAM_LOCATION}/readconfig.rb find #{config_option}`.strip! == 'false'
  puts "Configuration option [ #{config_option} ] set to 'false'"
  puts "exiting..."
  exit 0
end

craftbukkit_location = Dir.new("#{PROGRAM_LOCATION}/../lib")

# get craftbukkit meta-data (filename, perm-url) ===============================
print "downloading craftbukkit jar meta-data..."
perm_uri = URI(`#{PROGRAM_LOCATION}/readconfig.rb find craftbukkit_dl_link`.strip!)

session = Net::HTTP.new(perm_uri.host)
request = Net::HTTP::Get.new(perm_uri.request_uri)

response = session.request(request)
data = {:url => response["Location"], :filename => response["Location"].split("/").last}
puts "DONE"
# ==============================================================================

# look for a local craftbukkit.jar
current_jar_fname = craftbukkit_location.entries.grep(/^craftbukkit-.*\.jar/).first || ""

# if the local craftbukkit.jar is older than the one online, then download it
if (data[:filename] <=> current_jar_fname) > 0 # string comparison
  print "#{(current_jar_fname.empty?) ? "downloading" : "updating"} craftbukkit jar..."

  download_uri = URI(data[:url])

  session = Net::HTTP.new(download_uri.host)
  request = Net::HTTP::Get.new(download_uri.request_uri)

  response = session.request(request)

  data[:bin] = response.body

  # delete the current local jar if it exists
  unless current_jar_fname.empty?
    craftbukkit_jar_path = "#{craftbukkit_location.path}/#{current_jar_fname}"
    File.delete(craftbukkit_jar_path)
  end

  craftbukkit_jar_path = "#{craftbukkit_location.path}/#{data[:filename]}"
  File.open(craftbukkit_jar_path, "wb") do |file|
    file.write(data[:bin])
  end
  puts "DONE"
  puts "wrote #{File.expand_path(craftbukkit_jar_path)}"
else
  puts "craftbukkit jar is already up-to-date"
end
