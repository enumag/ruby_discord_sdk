require './discord'
puts "Successfully loaded discord extension"
Discord.connect(551158360083398656)
puts "Connected to Discord!" if Discord.connected?
Discord.update_activity({details:"test"})
Discord.update
Discord.update
Discord.update
gets
Discord.update_activity({})
Discord.update
Discord.update
Discord.update
gets
Discord.disconnect
gets 
Discord.connect(551158360083398656)
puts "Reconnected to Discord!" if Discord.connected?
gets
Discord.disconnect