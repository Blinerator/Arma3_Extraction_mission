_activation_unit = _this select 1;
_activation_group = group _activation_unit;

if(groupId _activation_group == "Alpha 1-1") then{
	if (groupId (group player) != "Alpha 1-2") then {
			hint "Already helped one of your kind.  Go away.";
	}forEach allPlayers;

}
else
{
	if (groupId (group player) != "Alpha 1-1") then {
			hint "Already helped one of your kind.  Go away.";
	}forEach allPlayers;
};