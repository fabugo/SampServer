// This is a comment
// uncomment the line below if you want to write a filterscript
#define FILTERSCRIPT

#include <a_samp>
#include <a_mysql>

#if defined FILTERSCRIPT

public OnFilterScriptInit()
{
	print("\n--------------------------------------");
	print(" Blank Filterscript by your name here");
	print("--------------------------------------\n");
	return 1;
}
public OnFilterScriptExit()
{
	return 1;
}

#else

main()
{
	print("\n----------------------------------");
	print(" Blank Gamemode by your name here");
	print("----------------------------------\n");
}

#endif
new isOnChatKill;
new mysql;
new login[45];
forward OnPlayerDataLoaded(playerid);
public OnGameModeInit()
{
	mysql = mysql_connect("127.0.0.1", "root", "blank", "fjhasql");
	if(mysql_errno() != 0)
		print("Could not connect to database!");
	else
		print("Conected");
	isOnChatKill = true;
	// Don't use these lines if it's a filterscript
	SetGameModeText("Blank Script");
	AddPlayerClass(0, 1958.3783, 1343.1572, 15.3746, 269.1425, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnGameModeExit()
{
	mysql_close(mysql);
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	return 1;
}

public OnPlayerConnect(playerid)
{
	new query[128], pname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
	mysql_format(mysql, query, sizeof(query), "SELECT password FROM `player` WHERE `name` = '%e' LIMIT 1", pname);
	mysql_pquery(mysql, query, "OnPlayerDataLoaded", "d", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}

public OnPlayerSpawn(playerid)
{
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(isOnChatKill)
		SendDeathMessage(killerid,playerid,reason);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/chatkill", cmdtext, true) == 0)
	{
		if(isOnChatKill)
			isOnChatKill = false;
		else
			isOnChatKill = true;
		return 1;
	}
	if (strcmp("/sucide", cmdtext, true) == 0)
	{
		SetPlayerHealth(playerid, 0);
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == 1)
	{
		if(response) // If they clicked 'Yes' or pressed enter
			if(strcmp(inputtext,login))
				ShowPlayerDialog(playerid,1, DIALOG_STYLE_INPUT, "Login", "Enter your password below:", "Login", "Cancel");
        else // Pressed ESC or clicked cancel
            Kick(playerid);
        return 1;
	}
	if(dialogid == 2)
	{
		if(response)
		{
			if(strcmp(inputtext," "))
			{
				new query[128], pname[MAX_PLAYER_NAME];
				GetPlayerName(playerid, pname, MAX_PLAYER_NAME);
				mysql_format(mysql, query, sizeof(query), "INSERT INTO player (name,password) VALUES ('%s','%s')", pname,inputtext);
				mysql_tquery(mysql, query);
				print("Cadstrado e logado");
			}
			else
				ShowPlayerDialog(playerid,2, DIALOG_STYLE_INPUT, "Register", "Enter your password below:", "Register", "Cancel");
		}
		else
            Kick(playerid);
		return 1;
	}
	return 1;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
public OnPlayerDataLoaded(playerid)
{
	cache_get_row(0, 0, login);
	if(cache_num_rows())
		ShowPlayerDialog(playerid,1, DIALOG_STYLE_INPUT, "Login", "Enter your password below:", "Login", "Cancel");
		return 1;
	else
		ShowPlayerDialog(playerid,2, DIALOG_STYLE_INPUT, "Register", "Enter your password below:", "Register", "Cancel");

	return 1;
}
