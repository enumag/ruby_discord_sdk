#ifndef DISCORDXP_H
#define DISCORDXP_H

#include "discord_game_sdk.h"

#define Discord_ActivityManager app.core->get_activity_manager(app.core)

typedef struct Application {
    struct IDiscordCore* core;
} Application;

#ifdef DISCORD_APPID
int Discord_Init();
#else
int Discord_Init(long clientid);
#endif
void Discord_Update();
void Discord_Shutdown();

void Discord_ActivityUpdate(char* state, char* details, char* large_image, char* large_image_text, char* small_image, char* small_image_text, long timestamp_start, long timestamp_end, int party_size, int party_max);

/*
DISCORDXP_API int Discord_UserGetCurrentId();
DISCORDXP_API const char* Discord_UserGetCurrentName();
DISCORDXP_API const char* Discord_UserGetCurrentDiscriminator();
DISCORDXP_API const char* Discord_UserGetCurrentAvatar();
*/

#endif