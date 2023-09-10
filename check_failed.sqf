check_downed_uncon = {
	_states = [];
	{
		if (groupId (group player) != "Alpha 1-2") then {
			_is_uncon = _x getVariable ["ACE_isUnconscious", false];
			_states pushBack !_is_uncon;
		};
	}forEach allPlayers;
	_states;//return states of all downed players.  True is uncon.
};

while {true} do{
	_alive = []; //alive states of all players in downed    call check_downed_uncon
	{
		if (groupId (group player) != "Alpha 1-2") then {
			_is_dead = alive _x; //returns true if alive
			_alive pushBack _is_dead;
		};
	}forEach allPlayers;
	
	_uncon_states = call check_downed_uncon;
	//_alive holds array with "true" if alive
	//_uncon_states holds array with "true" if consious.
	_number_of_players = count _alive;
	_num_of_dead_uncon_players = 0;
	for "_i" from 0 to _number_of_players-1 do{
		if((!(_alive select _i) || !(_uncon_states select _i)) && _number_of_players>0) then{
			_num_of_dead_uncon_players = _num_of_dead_uncon_players + 1;
		};
	};

	if ((_num_of_dead_uncon_players == _number_of_players) && _number_of_players>0) then{
		"Downed pilots have been captured and killed" remoteExec ["hint",0,true];
		sleep 5;
		["LOSER"] remoteExec ["endMission",0];
	};
	sleep 10;
};