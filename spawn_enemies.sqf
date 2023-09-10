
if(!isServer) exitWith {};
_spawnPosition = _this select 0;
_radio_towers = _this select 1;
patrol_groups = [];

elite_patrol = ["vn_o_men_pl_01", 
"vn_o_men_pl_11", 
"vn_o_men_pl_14", 
"vn_o_men_pl_07", 
"vn_o_men_pl_02", 
"vn_o_men_pl_13", 
"vn_o_men_pl_08"];
radio_tower_defense_groups = [];
// {
// 	radio_tower_defense_groups pushBack createGroup EAST;
// 	current_tower = _x;
// 	{
// 		_x createUnit [getPos current_tower,radio_tower_defense_groups select(count(radio_tower_defense_groups)-1)];
// 	}forEach elite_patrol;
// }forEach _radio_towers;

{
    _tower = _x; // Get the current radio tower from the array
    _towerPosition = getPosATL _tower; // Get the position of the tower
    _squad = createGroup east; // Replace 'east' with the desired faction for the squad

    {
        _unitClass = _x; // Get the unit class from the 'elite_patrol' array
        _unit = _squad createUnit [_unitClass, _towerPosition, [], 0, "NONE"];
		

    } forEach elite_patrol;
} forEach _radio_towers;


patrol_area = 1000;
// Define the bounds
min_x = 1000;
max_x = 13000;
min_y = 1000;
max_y = 13000;

// Calculate the marker's position to ensure it fits within the bounds
markerX = _spawnPosition select 0;
markerY = _spawnPosition select 1;
halfSize = patrol_area/2;

// Adjust marker position if necessary
if (markerX - halfSize < min_x) then {
    markerX = min_x + halfSize;
};
if (markerX + halfSize > max_x) then {
    markerX = max_x - halfSize;
};

if (markerY - halfSize < min_y) then {
    markerY = min_y + halfSize;
};
if (markerY + halfSize > max_y) then {
    markerY = max_y - halfSize;
};

markerPosition = [markerX, markerY, 0];

// Create the marker
Alpha_1 = createMarker ["Alpha_1", markerPosition];
Alpha_1 setMarkerShape "RECTANGLE";
Alpha_1 setMarkerSize [patrol_area, patrol_area];

patrol_group_leader = "vn_o_men_vc_local_01";
patrol_group = [ 
"vn_o_men_vc_local_26",
"vn_o_men_nva_dc_07",
"vn_o_men_vc_local_02", 
"vn_o_men_vc_local_03", 
"vn_o_men_vc_local_07", 
"vn_o_men_vc_local_08"];
patrol_groups = [];
_ofsets = [[1,1],[-1,1],[1,-1],[-1,-1]];
for "_i" from 0 to 3 do{
	x = _spawnPosition select 0;
	y = _spawnPosition select 1;
    _cur_offset = _ofsets select _i;
	x = x + 100 + random(patrol_area/2)*(_cur_offset select 0);
	y = y + 100 + random(patrol_area/2)*(_cur_offset select 1);
	patrol_groups pushBack createGroup EAST;
	patrol_group_leader createUnit [[x,y,1],patrol_groups select _i,"nul=[this,'Alpha_1'] execVM 'ups.sqf'"];
	{
		_x createUnit [[x,y,0],patrol_groups select _i];
	}forEach patrol_group;
};
//initial_patrol = createGroup EAST;
/*
spawnPos = [x_coord + random [150,300,450], y_coord + random [100,200,300], 0];
{
	initial_patrol createUnit [_x, spawnPos,[],0,"FORM"];
} forEach _patrol_squad;
 */
 