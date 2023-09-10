
if (groupId (group player) == "Alpha 1-2") then {
	re_loc = getmarkerpos "rescue_team_respawn";
	arg1 = re_loc select 0;
	arg2 = re_loc select 1;
	airdrop_loc = [round(arg1  + random[-100,0,100]), round(arg2  + random[-100,0,100]), 250];
	player setPos airdrop_loc;
	player addBackpack "B_Parachute";
	player action ["OpenParachute",player];
};
hint format["%1",groupId (group player)];
if (groupId (group player) == "Alpha 1-1") then {
	player setpos (getmarkerpos "downed_team_respawn");
	removeAllWeapons player;
};

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