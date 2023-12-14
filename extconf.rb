require 'mkmf'

LIBRARY_DIR = "#{Dir.pwd}/lib/x86_64"
LIBRARY_DIR_ARM = "#{Dir.pwd}/lib/aarch64"

if /mswin|mingw/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil)
elsif /darwin/ =~ RUBY_PLATFORM
    $LDFLAGS += '-L' + LIBRARY_DIR + ' -Wl,-rpath,. -Wl,-rpath,./lib -ldiscord_game_sdk -arch x86_64 '
    $LDFLAGS += '-L' + LIBRARY_DIR_ARM + ' -Wl,-rpath,. -Wl,-rpath,./lib -ldiscord_game_sdk -arch arm64 '
else
    $LDFLAGS += ' -L' + LIBRARY_DIR + ' -Wl,-R. -Wl,-R./lib -l:discord_game_sdk.so'
end

create_makefile 'discord'