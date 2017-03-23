//MIT License
//
//Copyright (c) [2017] [Neoony]
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.

#include <sourcemod>
#include <sdktools>

#define PluginVer "v0.2"
 
public Plugin myinfo =
{
	name = "No Commander Extend Vote",
	author = "Neoony",
	description = "Extend commander vote when nobody opted in and someone voted for him",
	version = PluginVer,
	url = "https://github.com/Neoony/No-Commander-Extend-Vote"
}

//ConVars
ConVar nc_setvotetime, nc_addvotetime, nc_minplayers, nc_msgtimer;

int origvotetime;
int addvotetime;
int minplayers;
int minplayersnr = 0;
int nf1vote = 0;
int be1vote = 0;
int commsready = 0;
int ClientNumber;
int cexist = 2;
int vtime;
int plugindone = 0;
float msgtimer;

public void OnPluginStart()
{
	//LoadTranslations("common.phrases");
	
	//Cvars
	nc_addvotetime = CreateConVar("nc_addvotetime", "20", "How much to add to the current detected value of commander vote time, when extending vote time.");
	nc_minplayers = CreateConVar("nc_minplayers", "2", "How many players needed to enable this plugin.(players in a team)");
	nc_msgtimer = CreateConVar("nc_msgtimer", "15", "How often to display the informational messages.");
	
	//Find all console variables
	nc_setvotetime = FindConVar("emp_sv_vote_commander_time");
	
	//Create or load config files
	AutoExecConfig(true, "NoCommExtendVote");
	addvotetime = nc_addvotetime.IntValue;
	minplayers = nc_minplayers.IntValue;
	msgtimer = nc_msgtimer.IntValue + 0.0;
	
	//Hook events
	HookEvent("commander_vote", Event_CommVote);
	HookEvent("commander_vote_time", Event_CommVoteTime);
	HookEvent("commander_elected_player", Event_ElectedPlayer);
	
	//Timers for messages
	CreateTimer(msgtimer, InfoMsg, _, TIMER_REPEAT);
	
	//Message
	PrintToChatAll("[NCEV]: No Commander Extend Vote by Neoony - Loaded");
}

public Action InfoMsg(Handle timer)
{
	if (commsready == 1 && plugindone != 1)
	{
		PrintToChatAll("[NCEV]: Both teams have a commander, not extending");
	}
	if (minplayersnr == 1 && plugindone != 1)
	{
		PrintToChatAll("[NCEV]: Not enough players - plugin disabled");
		//PrintToServer("[NCEV]: Not enough players - plugin disabled");
	}
	if (cexist == 0)
	{
		//PrintToChatAll("NCEV: Infantry map - plugin disabled");
		PrintToServer("NCEV: Infantry map - plugin disabled");
	}
	if (plugindone == 0)
	{
        return Plugin_Continue;
    }
	if (plugindone == 1)
	{
		return Plugin_Stop;
	}
	return Plugin_Continue;
}
	
public Event_CommVote(Handle:event, const char[] name, bool dontBroadcast)
{	
	//PrintToChatAll("commander_vote event");
	//PrintToServer("commander_vote event");
	int cvote = GetEventInt(event, "team");
	if (cvote == 0)
	{
		PrintToChatAll("[NCEV]: NF has received comm vote");
		//PrintToServer("[NCEV]: NF has received comm vote");
		nf1vote = 1;
	} 
	if (cvote == 1) 
	{
		PrintToChatAll("[NCEV]: BE has received comm vote");
		//PrintToServer("[NCEV]: BE has received comm vote");
		be1vote = 1;
	}
}
	
public Event_CommVoteTime(Handle:event, const char[] name, bool dontBroadcast)	
{
	cexist = GetEventInt(event, "commander_exists");
	vtime = GetEventInt(event, "time");
	GetConVarInt(nc_addvotetime);
	GetConVarInt(nc_minplayers);
	ClientNumber = GetClientCount();
	minplayers = nc_minplayers.IntValue;
	if (ClientNumber <  minplayers)
	{
		minplayersnr = 1
	}
	if (ClientNumber >=  minplayers)
	{
		minplayersnr = 0
	}
	//PrintToChatAll("commander_vote_time event");
	//PrintToServer("commander_vote_time event");
	if (cexist == 1 && minplayersnr == 0)
	{
		//PrintToChatAll("commander exists");
		//PrintToServer("commander exists");
		if (vtime < 60)
		{
			//PrintToChatAll("less than 60");
			//PrintToServer("less than 60");
			if (nf1vote == 1 && be1vote == 1)
			{
				commsready = 1;
			}
			if (nf1vote != 1)
			{
				PrintToChatAll("[NCEV]: NF has no commander, extending time");
			}
			if (be1vote != 1)
			{
				PrintToChatAll("[NCEV]: BE has no commander, extending time");
			}
			if (commsready != 1)
			{
				origvotetime = nc_setvotetime.IntValue;
				addvotetime = nc_addvotetime.IntValue;
				nc_setvotetime.IntValue = origvotetime + addvotetime;
			}
		}
	}
}
	
public Event_ElectedPlayer(Handle:event, const char[] name, bool dontBroadcast)
{	
	//PrintToChatAll("commander_elected_player event");
	//PrintToServer("commander_elected_player event");
	int enf = GetEventInt(event, "elected_nf_comm_id");
	int ebe = GetEventInt(event, "elected_be_comm_id");
	plugindone = 1;
	if (enf != -1)
	{
		PrintToChatAll("[NCEV]: NF elected commander");
		//PrintToServer("[NCEV]: NF elected commander");
	}
	if (enf == -1)
	{
		PrintToChatAll("[NCEV]: NF started with no commander");
		//PrintToServer("[NCEV]: NF started with no commander");
	}
	if (ebe != -1)
	{
		PrintToChatAll("[NCEV]: BE elected commander");
		//PrintToServer("[NCEV]: BE elected commander");
	}
	if (ebe == -1)
	{
		PrintToChatAll("[NCEV]: BE started with no commander");
		//PrintToServer("[NCEV]: BE started with no commander");
	}
}
