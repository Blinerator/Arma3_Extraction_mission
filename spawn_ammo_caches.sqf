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

_RTO = "vn_o_men_pl_13";

_flag = "vn_flag_pavn_dmg";

_static_mg = "vn_o_nva_65_static_pk_high";

spawn_ammo_cache = 
{
	params["_loc_x","_loc_y"];
	_offset = 0;

	createVehicle["vn_o_wheeled_z157_ammo_vcmf",[_loc_x+_offset,_loc_y,1],[],0,"NONE"];
	_offset = _offset + 5;
	createVehicle[selectRandom _vehicles,[_loc_x+_offset,_loc_y,1],[],0,"NONE"];
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