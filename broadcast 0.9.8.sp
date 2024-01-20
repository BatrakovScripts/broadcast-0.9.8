//fixed array out of bounds error
#include <sdktools>
#include <sdktools_functions>
#include <sourcemod>
#pragma semicolon 1
#define VERSION "0.9.8"

public Plugin:myinfo = {
	name = "L4D Broadcast",
	author = "Voiderest Доработка by Alexander Mirny(BatrakovScripts)",
	description = "Displays extra info for kills and friendly fire.",
	version = VERSION,
	url = "N/A"
}
new Handle:broadcast=INVALID_HANDLE;
new Handle:kill_timers[MAXPLAYERS+1][3];
new kill_counts[MAXPLAYERS+1][3];

public OnPluginStart() {
	//create new cvars
	broadcast = CreateConVar("l4d_broadcast_kill", "1", "0: Off. 1: On. 2: Headshots only.",FCVAR_REPLICATED|FCVAR_GAMEDLL|FCVAR_NOTIFY,true,0.0,true,2.0);
	
	//hook events
	HookEvent("player_death", Event_Player_Death, EventHookMode_Pre);
	
	AutoExecConfig(true,"l4d_broadcast");
	
}
public OnMapStart()
{
	char sBuffer[PLATFORM_MAX_PATH];
	Format(sBuffer, sizeof(sBuffer),"sound/quake/firstblood.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/headshot.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/megakill.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/ultrakill.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/godlike.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/monsterkill.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/killingspree.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/unstoppable.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	Format(sBuffer, sizeof(sBuffer),"sound/quake/dominating.mp3");
	AddFileToDownloadsTable(sBuffer);
	//
	PrecacheSound("quake/firstblood.mp3");
	PrecacheSound("quake/headshot.mp3");
	PrecacheSound("quake/megakill.mp3");
	PrecacheSound("quake/ultrakill.mp3");
	PrecacheSound("quake/godlike.mp3");
	PrecacheSound("quake/monsterkill.mp3");
	PrecacheSound("quake/killingspree.mp3");
	PrecacheSound("quake/unstoppable.mp3");
	PrecacheSound("quake/dominating.mp3");
}
public Action:Event_Player_Death(Handle:event, const String:name[], bool:dontBroadcast) {
	new attacker_userid = GetEventInt(event, "attacker");
	new attacker =  GetClientOfUserId(attacker_userid);
	new bool:headshot = GetEventBool(event, "headshot");
	
	if (attacker == 0 || GetClientTeam(attacker) == 1)
	{
		return Plugin_Continue;
	}
	
	printkillinfo(attacker, headshot);
	
	return Plugin_Continue;
}

printkillinfo(attacker, bool:headshot)
{
	new intbroad=GetConVarInt(broadcast);
	new murder;
	
	//new buffer[256];
	if ((intbroad >= 1) && headshot)
	{
		murder = kill_counts[attacker][0];
		
		if(murder>1)
		{
			switch(GetRandomInt(1, 5))
			{
				case 0: PrintHintText(attacker, "Mega: +%d Headshot",murder), EmitSoundToClient(attacker,"quake/headshot.mp3",_,_,_,_,1.0);
				case 1: PrintHintText(attacker, "Ultra: +%d Headshot",murder), EmitSoundToClient(attacker,"quake/headshot.mp3",_,_,_,_,1.0);
				case 2: PrintHintText(attacker, "Triple: +%d Headshot",murder), EmitSoundToClient(attacker,"quake/headshot.mp3",_,_,_,_,1.0);
				case 3: PrintHintText(attacker, "Monster: +%d Headshot",murder), EmitSoundToClient(attacker,"quake/headshot.mp3",_,_,_,_,1.0);
				case 4: PrintHintText(attacker, "Duble: +%d Headshot",murder), EmitSoundToClient(attacker,"quake/headshot.mp3",_,_,_,_,1.0);
			}
			KillTimer(kill_timers[attacker][0]);
		}
		else
		{
			PrintHintText(attacker, "Headshot"), EmitSoundToClient(attacker,"quake/headshot.mp3",_,_,_,_,1.0);
		}
		
		kill_timers[attacker][0] = CreateTimer(5.0, KillCountTimer, (attacker*10));
		kill_counts[attacker][0] = murder+1;
	}
	else if (intbroad == 1)
	{
		murder = kill_counts[attacker][1];
		
		if(murder>=1)
		{
			switch(GetRandomInt(1, 7))
			{
				case 0: PrintHintText(attacker, "Mega: +%d Kill",murder), EmitSoundToClient(attacker,"quake/megakill.mp3",_,_,_,_,1.0);
				case 1: PrintHintText(attacker, "Ultra: +%d Kill",murder), EmitSoundToClient(attacker,"quake/ultrakill.mp3",_,_,_,_,1.0);
				case 2: PrintHintText(attacker, "Godlike: +%d Kill",murder), EmitSoundToClient(attacker,"quake/godlike.mp3",_,_,_,_,1.0);
				case 3: PrintHintText(attacker, "Monster: +%d Kill",murder), EmitSoundToClient(attacker,"quake/monsterkill.mp3",_,_,_,_,1.0);
				case 4: PrintHintText(attacker, "Killingspree +%d Kill",murder), EmitSoundToClient(attacker,"quake/killingspree.mp3",_,_,_,_,1.0);
				case 5: PrintHintText(attacker, "Unstapobol: +%d Kill",murder), EmitSoundToClient(attacker,"quake/unstoppable.mp3",_,_,_,_,1.0);
				case 6: PrintHintText(attacker, "Dominating: +%d Kill",murder), EmitSoundToClient(attacker,"quake/dominating.mp3",_,_,_,_,1.0);
			}
			KillTimer(kill_timers[attacker][1]);
		}
		else
		{
			PrintHintText(attacker, "First Blood"), EmitSoundToClient(attacker,"quake/firstblood.mp3",_,_,_,_,1.0);
		}
		
		kill_timers[attacker][1] = CreateTimer(5.0, KillCountTimer, ((attacker*10)+1));
		kill_counts[attacker][1] = murder+1;
	}
}

public Action:KillCountTimer(Handle:timer, any:info) {
	new id=info-(info%10);
	info=info-id;
	id=id/10;
	
	kill_counts[id][info]=0;
}
