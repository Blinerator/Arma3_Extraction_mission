{
if (groupId (group player) != "Alpha 1-1") then {
		hint format["Page 1: Crash reported at grid %1,%2",round((spawnPosition select 0)),round((spawnPosition select 1))];
	};
}forEach allPlayers;