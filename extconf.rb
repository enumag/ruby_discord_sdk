require 'mkmf'

raise "Invalid number of arguments" if ARGV.length == 0
raise "Invalid architecture #{ARGV[0]}" if !["x86", "x86_64", "arm64", "aarch64"].include?(ARGV[0])

LIBRARY_DIR = "#{Dir.pwd}/lib/#{ARGV[0]}"

$defs.push("-DDISCORD_APPID=#{ARGV[1]}") if ARGV.length > 1

if /cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM
    find_library("discord_game_sdk", nil, LIBRARY_DIR)
elsif /darwin/ =~ RUBY_PLATFORM
    $LDFLAGS += ' -L' + LIBRARY_DIR + ' -Wl,-rpath,. -Wl,-rpath,./lib -ldiscord_game_sdk -arch ' + ARGV[0] + ' '
    $CPPFLAGS += '-Wno-incompatible-function-pointer-types'
    $ARCH_FLAG += '-arch ' + ARGV[0]
else
    $LDFLAGS += ' -L' + LIBRARY_DIR + ' -Wl,-R. -Wl,-R./lib -l:discord_game_sdk.so'
end

create_makefile 'discord'