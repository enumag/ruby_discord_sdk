require 'mkmf'

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
elsif /linux/ =~ RUBY_PLATFORM
    $LDFLAGS += " -L./lib/x86_64 -Wl,-R. -l:discord_game_sdk.so"
elsif /darwin/ =~ RUBY_PLATFORM
    $LDFLAGS += " -L./lib/x86_64 -rpath . -ldiscord_game_sdk"
else
    raise "Unknown RUBY_PLATFORM: " + RUBY_PLATFORM
end

puts "RUBY_PLATFORM: " + RUBY_PLATFORM
puts "$LDFLAGS: " + $LDFLAGS

create_makefile 'discord'
