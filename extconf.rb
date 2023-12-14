require 'mkmf'

$LDFLAGS += ' -v'

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
elsif /darwin/ =~ RUBY_PLATFORM
    $LDFLAGS += ' -Wl,-rpath,. -ldiscord_game_sdk -arch arm64'
    $ARCH_FLAG += ' -arch arm64'
else
    $LDFLAGS += ' -Wl,-R. -l:discord_game_sdk.so'
end

puts "$LDFLAGS: " + $LDFLAGS

create_makefile 'discord'
