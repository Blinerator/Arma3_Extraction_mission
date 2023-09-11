//randomize pilot spawn between the four airfields
//LIMIT RESCUE TEAM ALT
if(!isServer) exitWith {};

min_x = 1000;
max_x = 13000;
min_y = 1000;
max_y = 13000;

//define enemy patrol squad:
_patrol_squad = ["vn_o_men_vc_regional_01","vn_o_men_vc_regional_06","vn_o_men_vc_regional_02","vn_o_men_vc_regional_12","vn_o_men_vc_regional_14"];



//spawn radio towers:
radioTowerClass = "Land_vn_communication_f";
radioTower_markers = [];
towers_spawned = 0;
iteration_counter = 0;
radio_towers = [];
radio_tower_defense_groups = [];

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
		} forEach radioTower_markers;
		
		if(distanceValid) then {
			radio_towers pushBack createVehicle [radioTowerClass, [x_coord,y_coord]];
			radioTower_markers pushBack createMarker ["Tower"+str towers_spawned,[x_coord,y_coord,0]];
			towers_spawned = towers_spawned + 1;
		}
	}
};

{
	_x setMarkerType "hd_unknown";
}forEach radioTower_markers;


min_x = 500;
max_x = 14500;
min_y = 500;
max_y = 14500;

//spawn rescue team:
//locations: [9758.94,6643.89,0], [11023.1,3177.34,0],[4669.41,1013.97,0],[10689,13377.7,0],
rescue_team_spawn_locations = [[9758.94,6643.89,0],[11023.1,3177.34,0],[10689,13377.7,0]];
rescue_team_spawn_location = selectRandom rescue_team_spawn_locations;
rescue_helicopter setPos rescue_team_spawn_location;
rescue_helicopter addItemCargoGlobal ["vn_mx991_red",4];
//spawn downed pilots:
x_coord = floor(random(max_x-min_x) + min_x);
y_coord = floor(random(max_y-min_y) + min_y);
spawnPosition = [x_coord, y_coord];
publicVariable "spawnPosition";
//create destroyed plane:
destroyedVehicle = "vn_b_air_f4b_navy_sead" createVehicle [0,0,0];
//destroyedVehicle setDamage 1;
destroyedVehicle setPos [x_coord + random(100)+50, y_coord + random(100)+50,100];

//spawn enemy patrol:
initial_patrol = createGroup EAST;
spawnPos = [x_coord + random [150,300,450], y_coord + random [100,200,300], 0];
{
	initial_patrol createUnit [_x, spawnPos,[],0,"FORM"];
} forEach _patrol_squad;
initial_patrol addWaypoint[spawnPosition, 10];
//activate enemy helicopter "helicopter_patrol:
execVM "helicopter_patrol.sqf";

//Mark approximate location on map:
shadedRegionWidth = 2500; 
shadedRegionHeight = 2500; 
playerPosition = spawnPosition;
shadedRegionPosition = [x_coord - random shadedRegionHeight, y_coord - random shadedRegionWidth, 0];

shadedRegionMarker = createMarker ["ShadedRegionMarker", shadedRegionPosition];
shadedRegionMarker setMarkerShape "ELLIPSE";
shadedRegionMarker setMarkerSize [shadedRegionWidth, shadedRegionHeight];
shadedRegionMarker setMarkerColor "ColorRed";
shadedRegionMarker setMarkerAlpha 0.25;
{
	if (groupId (group player) != "Alpha 1-1") then {
		shadedRegionMarker setmarkerAlphaLocal 0; // Hide the marker
	};
}forEach playableUnits;

//launch pertinent scripts:
execVM "randomize_time.sqf";
execVM "real_weather.sqf";
[spawnPosition,radio_towers] execVM "spawn_enemies.sqf";
execVM "update_respawn_loc.sqf";
execVM "check_failed.sqf";
execVM "spawn_start_loot.sqf";
execVM "initial_patrol_waypoint.sqf";
execVM "spawn_ammo_caches.sqf";
execVM "init_villages.sqf";
execVM "remove_nav_items.sqf";
execVM "periodic_ambush.sqf";
//This array is for making sure no duplicate elder events occure:
already_occured_elder_event_rescue = [];
already_occured_elder_event_downed = [];