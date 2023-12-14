require 'mkmf'

puts 'before'
puts $LDFLAGS

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
elsif /darwin/ =~ RUBY_PLATFORM
    $LDFLAGS += ' -v -L. -Wl,-rpath,. -Wl,-rpath,./lib -ldiscord_game_sdk -arch arm64'
else
    $LDFLAGS += ' -v -L. -Wl,-R. -Wl,-R./lib -l:discord_game_sdk.so'
end

puts 'after'
puts $LDFLAGS

create_makefile 'discord'
