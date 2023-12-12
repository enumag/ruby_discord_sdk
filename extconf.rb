require 'mkmf'

LIBRARY_DIR = "#{Dir.pwd}/lib/x86_64"

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
elsif /darwin/ =~ RUBY_PLATFORM
    $LDFLAGS += ' -L' + LIBRARY_DIR + ' -rpath. -rpath./lib -l:discord_game_sdk.dylib'
else
    $LDFLAGS += ' -L' + LIBRARY_DIR + ' -Wl,-rpath. -Wl,-rpath./lib -l:discord_game_sdk.so'
end

create_makefile 'discord'