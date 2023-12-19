require './discord'
puts "Successfully loaded discord extension"
Discord.connect(551158360083398656)
puts "Connected to Discord!" if Discord.connected?