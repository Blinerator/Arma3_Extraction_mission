hint "Searching...";
sleep 5;
_pos = getPos downed_0;
if (groupId (group player) != "Alpha 1-1") then {
		hint format["You find a charred notebook page: Lưới của phi công địch nhìn thấy %1,%2",round((_pos select 0)),round((_pos select 1))];
}forEach allPlayers;
_this select 0 removeaction (_this select 2);