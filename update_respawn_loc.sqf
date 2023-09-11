while {true} do{
	downed_respawn_loc = spawnPosition;
	{
		downed_respawn_loc = getPos downed_0;
	}forEach units downed_team;
	
	rescue_respawn_loc = [0,0,0];
	{
		rescue_respawn_loc = getPos _x;
	}forEach units rescue_team;

	"downed_team_respawn" setMarkerPos [downed_respawn_loc select 0,downed_respawn_loc select 1];
	"rescue_team_respawn" setMarkerPos [rescue_respawn_loc select 0,rescue_respawn_loc select 1];

	sleep 5;
};