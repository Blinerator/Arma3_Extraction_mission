//randomize pilot spawn between the four airfields
//LIMIT RESCUE TEAM ALT

min_x = 1000;
max_x = 13000;
min_y = 1000;
max_y = 13000;

//define enemy patrol squad:
_patrol_squad = ["vn_o_men_vc_regional_01","vn_o_men_vc_regional_06","vn_o_men_vc_regional_02","vn_o_men_vc_regional_12","vn_o_men_vc_regional_14"];

//spawn radio towers:
radioTowerClass = "Land_vn_communication_f";
_radioTower_markers = [];
towers_spawned = 0;
iteration_counter = 0;
radio_towers = [];
while {towers_spawned < 5} do {
	x_coord = floor(random(max_x-min_x) + min_x);
	y_coord = floor(random(max_y-min_y) + min_y);
	
	//check if is on hill:
	altitudeASL = getTerrainHeightASL [x_coord, y_coord];
	if (altitudeASL > 250) then {
		distanceValid = true;
		{
			pastTower = _x;
			towerPos = getMarkerPos pastTower;
			dist = towerPos distance [x_coord,y_coord,altitudeASL];
			if(dist < 4000) then {
				distanceValid = false;
				break;
			}
		} forEach _radioTower_markers;
		
		if(distanceValid) then {
			//tower = createVehicle [radioTowerClass, [x_coord,y_coord]];
			radio_towers pushBack createVehicle [radioTowerClass, [x_coord,y_coord]];
			_radioTower_markers pushBack createMarker ["Tower"+str towers_spawned,[x_coord,y_coord,0]];
			towers_spawned = towers_spawned + 1;
		}
	}
};

//add action to activate radio transmission:
{
	_x addAction [
		"Activate Radio Transmission",
		{
			tower_pos = getPos (_this select 0);
			arg1 = tower_pos select 0;
			arg2 = tower_pos select 1;
			approx_pos = [round(arg1  + random[-200,0,200]), round(arg2  + random[-200,0,200])];
			msg = format["Transmission: %1",approx_pos];
			[
				[
					[msg, "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t>"],
					["", "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
					["", "<t align = 'center' shadow = '1' size = '1.0'>%1</t>", 15]
				]
			] spawn BIS_fnc_typeText;
		}
	];
} forEach radio_towers;

// Define the list of players who can see the markers
allowedPlayers = [downed_0, downed_1];
{
	_x setMarkerType "hd_unknown";
	// Hide the marker for players not in the allowed list
	if (!(player in allowedPlayers)) then {
		_x setMarkerAlpha 0; // Hide the marker
	}
} forEach _radioTower_markers;

min_x = 500;
max_x = 14500;
min_y = 500;
max_y = 14500;

//spawn rescue team:
//locations: [9758.94,6643.89,0], [11023.1,3177.34,0],[4669.41,1013.97,0],[10689,13377.7,0],
rescue_team_spawn_locations = [[9758.94,6643.89,0],[11023.1,3177.34,0],[10689,13377.7,0]];
rescue_helicopter setPos selectRandom rescue_team_spawn_locations;

//spawn downed pilots:
x_coord = floor(random(max_x-min_x) + min_x);
y_coord = floor(random(max_y-min_y) + min_y);
_spawnPosition = [x_coord, y_coord];
publicVariable "_spawnPosition";
//create destroyed plane:
destroyedVehicle = "vn_b_air_f4b_navy_sead" createVehicle [0,0,0];
destroyedVehicle setDamage 1;
destroyedVehicle setPos [x_coord + random(100)+50, y_coord + random(100)+50];

//spawn enemy patrol:
initial_patrol = createGroup EAST;
spawnPos = [x_coord + random [150,300,450], y_coord + random [100,200,300], 0];
{
	initial_patrol createUnit [_x, spawnPos,[],0,"FORM"];
} forEach _patrol_squad;
initial_patrol addWaypoint[_spawnPosition, 10];
initial_patrol addWaypoint[_spawnPosition, 0];
//activate enemy helicopter "helicopter_patrol:
execVM "helicopter_patrol.sqf";

//spawn players:
downed_0 setPos [_spawnPosition select 0, _spawnPosition select 1, 100];
downed_1 setPos [_spawnPosition select 0, _spawnPosition select 1, 100];

downed_0 addBackpack "B_Parachute";
downed_1 addBackpack "B_Parachute";

downed_0 action ["OpenParachute",downed_0];
downed_1 action ["OpenParachute",downed_1];

//Mark approximate location on map:
shadedRegionWidth = 2500; 
shadedRegionHeight = 2500; 
playerPosition = _spawnPosition;
shadedRegionPosition = [x_coord - random shadedRegionHeight, y_coord - random shadedRegionWidth, 0];

shadedRegionMarker = createMarker ["ShadedRegionMarker", shadedRegionPosition];
shadedRegionMarker setMarkerShape "ELLIPSE";
shadedRegionMarker setMarkerSize [shadedRegionWidth, shadedRegionHeight];
shadedRegionMarker setMarkerColor "ColorRed";
shadedRegionMarker setMarkerAlpha 0.25;

// Hide the marker for players not in the allowed list
{
    if (!(player in allowedPlayers)) then {
        _x setMarkerAlpha 0; // Hide the marker
    }
} forEach [shadedRegionMarker];

execVM "spawn_enemies.sqf";