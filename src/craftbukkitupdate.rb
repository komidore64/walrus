#!/usr/bin/env ruby

# TODO make this work!

require 'net/http'

perm_uri = URI("http://dl.bukkit.org/downloads/craftbukkit/get/latest-rb/craftbukkit.jar") # put url into a configurable variable

session = Net::HTTP.new(perm_uri.host)
request = Net::HTTP::Get.new(perm_uri.request_uri)

response = session.request(request)
data = {:url => response["Location"], :filename => response["Location"].split("/").last}
latest_jar = data[:filename]

# get the current jar name, or an empty string if jar does not exist
current_jar = @crafty_dir.entries.grep(/^craftbukkit-.*\.jar/).first || ""

if (latest_jar <=> current_jar) > 0 # string comparison
  print "#{(current_jar == "") ? "downloading" : "updating"} craftbukkit jar..."

  craftbukkit_jar_path = [@crafty_dir.path, current_jar].join("/")
  File.delete(craftbukkit_jar_path) unless current_jar == ""

  data = {}

  dl_info = get_direct_dl_info()

  data[:filename] = dl_info[:filename]
  dl_uri = URI(dl_info[:url])

  session = Net::HTTP.new(dl_uri.host)
  request = Net::HTTP::Get.new(dl_uri.request_uri)

  response = session.request(request)

  data[:bin] = response.body

  craftbukkit_jar_path = [@crafty_dir.path, data[:filename]].join("/")
  f = File.open(craftbukkit_jar_path, "wb")
  f.write(data[:bin])
  f.close
  puts "DONE"
  return true
end
return false


