sleep 0.25;
//spawn players:
// if (groupId (group player) == "Alpha 1-1") then {

// 	player setPos [spawnPosition select 0, spawnPosition select 1, 100];

// 	player addBackpack "B_Parachute";

// 	player action ["OpenParachute",downed_0];
// };

//disable channels to prevent map seen by both "teams"
0 enableChannel false;
1 enableChannel false;
2 enableChannel false;

{
    if (groupId (group _x) == "Alpha 1-1" && side _x == west) then {
        setViewDistance 1500;

        _x setPos [spawnPosition select 0, spawnPosition select 1, 100];

        _x addBackpack "B_Parachute";

        _x action ["OpenParachute",_x];
    }
    else
    {
        setViewDistance 1500;
    };
}forEach allUnits;


// Hide the marker for players not in the allowed list
{
	if (groupId (group player) != "Alpha 1-1") then {
		_x setmarkerAlphaLocal 0; // Hide the marker
	}
} forEach radioTower_markers;

if (groupId (group player) != "Alpha 1-1") then {
    shadedRegionMarker setmarkerAlphaLocal 0; // Hide the marker
};

{
	if (groupId (group player) != "Alpha 1-1") then {
		_x setmarkerAlphaLocal 0; // Hide the marker
	}
} forEach ammocache_markers;

player addAction
[
    "Transmit Distress Signal",
    "radio_transmit.sqf",//[getPos player] remoteExec ["radio_transmit.sqf",0], // Take the code from your flip vehicle script and put it in a file called flip.sqf
    getPos player,
    1.5,
    false,
    true,
    "",
   "cursorTarget isKindOf 'Land_vn_communication_f'"
];










// sleep 10;
// {
// 	_x addAction [
// 		"Activate Radio Transmission",
// 		{
// 			tower_pos = getPos (_this select 0);
// 			arg1 = tower_pos select 0;
// 			arg2 = tower_pos select 1;
// 			approx_pos = [round(arg1  + random[-200,0,200]), round(arg2  + random[-200,0,200])];
// 			msg = format["Transmission: %1",approx_pos];
// 			[
// 				[
// 					[msg, "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t>"],
// 					["", "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
// 					["", "<t align = 'center' shadow = '1' size = '1.0'>%1</t>", 15]
// 				]
// 			] spawn BIS_fnc_typeText;
// 		}
// 	];
// }forEach radio_towers;

// initPlayerLocal.sqf

// downed_0 setPos [spawnPosition select 0, spawnPosition select 1, 100];
// downed_1 setPos [spawnPosition select 0, spawnPosition select 1, 100];

// downed_0 addBackpack "B_Parachute";
// downed_1 addBackpack "B_Parachute";

// downed_0 action ["OpenParachute",downed_0];
// downed_1 action ["OpenParachute",downed_1];

//Set up respawn for both teams:
// player addEventHandler ["Respawn", {
// 	if (groupId (group player) == "Alpha 1-2") then {
// 		re_loc = getmarkerpos "rescue_team_respawn";
// 		arg1 = re_loc select 0;
// 		arg2 = re_loc select 1;
// 		airdrop_loc = [round(arg1  + random[-100,0,100]), round(arg2  + random[-100,0,100]), 250];
// 		player setPos airdrop_loc;
// 		player addBackpack "B_Parachute";
// 		player action ["OpenParachute",player];
// 	};
	
// 	if (groupId (group player) == "Alpha 1-1") then {
// 		player setpos (getmarkerpos "downed_team_respawn");
// 	};
// }];

// Define the list of players who can see the markers
// allowedPlayers = [downed_0, downed_1];
// {
// 	_x setMarkerType "hd_unknown";
// 	// Hide the marker for players not in the allowed list
//hint format["%1",groupId (group player)];