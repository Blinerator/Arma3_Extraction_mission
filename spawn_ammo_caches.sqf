_ammo = ["vn_o_ammobox_full_04", 
"vn_b_ammobox_supply_05", 
"vn_b_ammobox_full_10", 
"vn_b_ammobox_full_31"];

_vehicles = ["vn_c_wheeled_m151_01","vn_c_car_04_01","vn_o_nva_65_static_pk_high","vn_o_wheeled_z157_mg_01_vcmf"];

_squad = ["vn_o_men_vc_local_01", 
"vn_o_men_vc_local_02", 
"vn_o_men_vc_local_03", 
"vn_o_men_vc_local_07", 
"vn_o_men_vc_local_08"];

_weapons = [["vn_type56","vn_type56_mag"],["vn_sks","vn_sks_mag"],["vn_dp28","vn_dp28_mag"],["vn_rpg2","vn_rpg2_mag"],["vn_m79_p","vn_40mm_m406_he_mag"],["vn_l1a1_01_camo","vn_l1a1_30_02_mag"],["vn_vz54_sniper","vn_m38_mag"],["vn_sks","vn_sks_mag"]];

_flare = [["vn_m127","vn_m129_mag"]];

_RTO = "vn_o_men_pl_13";

_flag = "vn_flag_pavn_dmg";

_static_mg = "vn_o_nva_65_static_pk_high";

spawn_ammo_cache = 
{
	params["_loc_x","_loc_y"];
	_offset = 0;

	_veh = createVehicle["vn_o_wheeled_z157_repair_kr",[_loc_x+_offset,_loc_y,1],[],0,"NONE"];

	_rand_wp = selectRandom _weapons;
	_wp = _rand_wp select 0;
	_ammo = _rand_wp select 1;

	_veh addItemCargoGlobal [_wp,1];
	_veh addItemCargoGlobal [_ammo,20];

	_rand_wp = selectRandom _weapons;
	_wp = _rand_wp select 0;
	_ammo = _rand_wp select 1;

	_veh addItemCargoGlobal [_wp,1];
	_veh addItemCargoGlobal [_ammo,20];

	_veh addItemCargoGlobal ["vn_o_item_map",1];
	_veh addItemCargoGlobal ["vn_o_item_radio_m252",1];

	_offset = _offset + 5;
	_offset = _offset + 2;

	createVehicle[_flag,[_loc_x-_offset,_loc_y-_offset,0],[],0,"NONE"];
	_offset = _offset + 2;

	_grp = createGroup EAST;
	{
		_x createUnit [[_loc_x-_offset,_loc_y,0],_grp];
	}forEach _squad;

	_temp = random 10;
	if(_temp == 5) then {
		_RTO createUnit [[_loc_x+_offset,_loc_y+_offset,0],_grp];
	};
	_wpnt = _grp addWaypoint[[_loc_x,_loc_y],100];
	_wpnt = _grp addWaypoint[[_loc_x,_loc_y],100];
	_wpnt = _grp addWaypoint[[_loc_x,_loc_y],100];
	_wpnt setWaypointType "CYCLE";
	_grp setBehaviour "SAFE";

};

_caches_spawned = 0;
_radius = 5000;

//for reference:
// min_x = 500;
// max_x = 14500;
// min_y = 500;
// max_y = 14500;
_sp_X = spawnPosition select 0;
_sp_Y = spawnPosition select 1;
ammocache_markers = [];
while {_caches_spawned < 5} do{
	randomX = _sp_X + ((random _radius * 2) - _radius);
	randomY = _sp_Y + ((random _radius * 2) - _radius);

	if(randomX>min_x && randomX<max_x && randomY>min_y && randomY<max_y)then{
		[randomX, randomY] call spawn_ammo_cache;
		_m = createMarker ["marker"+str(_caches_spawned),[randomX,randomY]];
		_m setMarkerType "hd_warning";
		ammocache_markers pushBack _m;
		_caches_spawned = _caches_spawned + 1;
	};
};
{
	_p = _x;
	{
		if (groupId (group _p) != "Alpha 1-1") then {
			_x setMarkerAlphaLocal 0; // Hide the marker
		}
	} forEach ammocache_markers;
}forEach allPlayers;