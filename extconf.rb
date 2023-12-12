require 'mkmf'

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
elsif /linux/ =~ RUBY_PLATFORM
    $LDFLAGS += " -L./lib/x86_64 -Wl,--rpath=. -l:discord_game_sdk.so"
elsif /darwin/ =~ RUBY_PLATFORM
    $LDFLAGS += " -v -L. -l:discord_game_sdk.dylib"
else
    raise "Unknown RUBY_PLATFORM: " + RUBY_PLATFORM
end

puts "RUBY_PLATFORM: " + RUBY_PLATFORM
puts "$LDFLAGS: " + $LDFLAGS

create_makefile 'discord'
