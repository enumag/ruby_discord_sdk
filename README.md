## Compilation
### mkxp-z (Pokémon Essentials) pre step
**You can skip this step if you aren't using mkxp-z or if you know for a fact your version of mkxp uses Windows' Universal C Runtime**\
[Follow mkxp-z's Windows compilation guide](https://github.com/mkxp-z/mkxp-z/wiki/Compilation#windows)\
Follow ALL steps EXACTLY right up to actually building mkxp-z itself. you don't need to do that.
You just need to find the Ruby that you just built. It should be in `[mkxp-z directory]/windows/build-mingw64/bin`\
Add that directory to your path environment variable, ABOVE THE EXISTING RUBY PATH. THIS IS VERY IMPORTANT \
Now that you've done that you can follow the rest of the instructions.

### Universal
In the repository directory, run `ruby extconf.rb [architecture, typically x86_64 or arm64] [your game's discord app id]`\
This will generate a makefile, for the uninitiated that is a glorified list of commands used to compile code which you can run by using the command `make`.

### macOS post step
You're going to run the build process twice, one time for x86_64 and one time for arm64. each time you should save the resulting .bundle as a separate file, i save them with their architecture as the file extension.\
Once you have both versions of the extension, run `lipo -create -output discord.bundle discord.x86_64 discord.arm64`to create a universal version.\
You'll also want to run `lipo -create -output discord_game_sdk.dylib ./lib/x86_64/libdiscord_game_sdk.dylib ./lib/arm64/libdiscord_game_sdk.dylib` to create a universal version of the discord sdk itself
One more thing! "Because macOS", you need to do a little meddling with your final `discord.bundle` in order to get it to work with mkxp-z.
Run these commands:
```
LIBRUBY=`otool -L discord.bundle | grep libruby | awk '{print $1}'`
install_name_tool -change $LIBRUBY @rpath/`echo $LIBRUBY | sed 's~.*/~~'` discord.bundle
```
This changes where the extension will look when trying to link itself to Ruby.

If you don't own a mac or linux computer and would still like to compile the extension to hide your game's app id, you can duplicate the extension's github repository and add your game's app ID to each instance of `ruby ./extconf.rb [arch]`inside autobuild.yml
## Functions
### Discord#connect
args (if app ID not provided at compile time): Application ID (Integer)\
args (if app ID provided at compile time): none

Connect to Discord. You may provide an application ID at compile time by defining it as preprocessor macro `DISCORD_APPID`.

### Discord#update
args: none

Run Discord callbacks, should be called once per frame\
Here is an RGSS example
```Ruby
module Graphics
    class << self
        alias discord_update__ update unless method_defined?(:discord_update__)
    end

    def self.update
        Discord.update
        discord_update__
    end
end
```


### Discord#update_activity
args: Activity details (Hash)

Update discord activities/rich presence information\
here is an rgss example
```Ruby
Discord.update_activity({
    :details => "Overworld",
    :state => "The name of a map",
    :start_timestamp => 1507665886,
    :end_timestamp => 1507665936,
    :large_image => "large_image_cloud_asset_name",
    :large_image_text => "Large Image Text",
    :small_image => "small_image_cloud_asset_name",
    :small_image_text => "Small Image Text",
    :party_id => "ae488379-351d-4a4f-ad32-2b9b01c91657",
    :party_size => 5,
    :party_max => 6,
    :join_secret => "MTI4NzM0OjFpMmhuZToxMjMxMjM= "
})
```

You do not have to include every field here\
Please respect the data types or you will crash your game


### Discord#add_event_callback
args: Target event (Symbol), Callback (proc)

Add a proc to be called by the specified event\
The events are:

`:on_activity_join` -> fires when a user accepts an invite or receieves confirmation from asking to join\
`:on_activity_spectate` -> fires when a user accepts a spectate invite or clicks the spectate button on a user's profile\
`:on_activity_join_request` -> fires when a user asks to join the current user's game\
`:on_activity_invite` -> fires when the user receives a join or spectate invite

These events, alongside #send_request_reply, can be used to build rich multiplayer integration with Discord.


### Discord#send_request_reply
args: Joiner User ID (Integer), Discord::ActivityJoinRequestReply (NO, YES, IGNORE)

Returns Discord::Result via callback passed as block
