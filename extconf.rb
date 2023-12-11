require 'mkmf'

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
else
    LIBRARY_DIR = "#{Dir.pwd}/lib/x86_64"
    $LDFLAGS += ' -L' + LIBRARY_DIR + ' -Wl,-R. -Wl,-R./lib -l:discord_game_sdk.so'
 end

create_makefile 'discord'