#!/usr/bin/env ruby

# TODO make this work!
$stdout.sync = true

require 'net/http'

PROGRAM_LOCATION = File.dirname(__FILE__)

exit if `#{PROGRAM_LOCATION}/configreader.rb find autoupdate_jar` == 'false'

craftbukkit_location = Dir.new("#{PROGRAM_LOCATION}/../lib")

print "downloading craftbukkit jar meta-data..."
perm_uri = URI(`#{PROGRAM_LOCATION}/configreader.rb find craftbukkit_dl_link`)

session = Net::HTTP.new(perm_uri.host)
request = Net::HTTP::Get.new(perm_uri.request_uri)

response = session.request(request)
data = {:url => response["Location"], :filename => response["Location"].split("/").last}
puts "DONE"

current_jar_fname = craftbukkit_location.entries.grep(/^craftbukkit-.*\.jar/).first || ""

if (data[:filename] <=> current_jar_fname) > 0 # string comparison
  print "#{(current_jar_fname.empty?) ? "downloading" : "updating"} craftbukkit jar..."

  unless current_jar_fname.empty?
    craftbukkit_jar_path = [craftbukkit_location.path, current_jar_fname].join("/")
    File.delete(craftbukkit_jar_path)
  end

  download_uri = URI(data[:url])

  session = Net::HTTP.new(download_uri.host)
  request = Net::HTTP::Get.new(download_uri.request_uri)

  response = session.request(request)

  data[:bin] = response.body

  craftbukkit_jar_path = [craftbukkit_location.path, data[:filename]].join("/")
  f = File.open(craftbukkit_jar_path, "wb")
  f.write(data[:bin])
  f.close
  puts "DONE"
else
  puts "craftbukkit jar is already up-to-date"
end
