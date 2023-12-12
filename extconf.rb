require 'mkmf'

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
elsif /linux/ =~ RUBY_PLATFORM
    $LDFLAGS += " -L./lib/x86_64 -Wl,-R. -l:discord_game_sdk.so"
elsif /macos/ =~ RUBY_PLATFORM
    $LDFLAGS += " -L./lib/x86_64 -L./lib/aarch64 -Wl,-R. -arch x86_64 -arch arm64 -l:discord_game_sdk.dylib"
end

puts $LDFLAGS

create_makefile 'discord'
