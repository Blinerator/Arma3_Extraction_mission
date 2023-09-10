//"vn_o_air_mi2_01_01";
//First base:[7049.61,10003.3,0]
//Second base:[4473.91,988.558,0]


sleep 1;
_x_coord = floor(random(max_x-min_x) + min_x);
_y_coord = floor(random(max_y-min_y) + min_y);
_bases = [[4669.1,1014.58,0],[7162.85,10025.7,0]];
//_veh = createVehicle["vn_o_air_mi2_01_01",[_x_coord,_y_coord,100],[],0,"NONE"];
_grp = createGroup EAST;
scout_helicopter = [[_x_coord,_y_coord,100],0,"vn_o_air_mi2_01_01",_grp] call BIS_fnc_spawnVehicle;
_sct_hel_obj = scout_helicopter select 0;
_x_coord = floor(random(max_x-min_x) + min_x);
_y_coord = floor(random(max_y-min_y) + min_y);
_grp addWaypoint[[_x_coord,_y_coord,0],50];
_wpnt = _grp addWaypoint[selectRandom _bases,50];
//_wpnt = _grp addWaypoint[selectRandom _bases,50];
_x_coord = floor(random(max_x-min_x) + min_x);
_y_coord = floor(random(max_y-min_y) + min_y);
_wpnt = _grp addWaypoint[[_x_coord,_y_coord,0],50];
_x_coord = floor(random(max_x-min_x) + min_x);
_y_coord = floor(random(max_y-min_y) + min_y);
_wpnt = _grp addWaypoint[[_x_coord,_y_coord,0],50];
_wpnt setWaypointType "CYCLE";

_sct_hel_obj addAction
[ 
	"Search", 
	"search_scout_wreck.sqf", 
	nil, 
	1.5, 
	true, 
	true, 
	"", 
	"true", 
	10, 
	false, 
	"", 
	""
];
_marker = createMarker ["scout_helo",getPos _sct_hel_obj];
_marker setMarkerType "hd_dot";
_marker setMarkerColor "ColorRed";
while{true} do{
	sleep 2.5;
	"scout_helo" setMarkerPos getPos _sct_hel_obj;
	if(!alive _sct_hel_obj) then{
		sleep 20;
		_pos = getPos _sct_hel_obj;
		//smoke_effect
		smoke_effect setPos _pos;
		//"vn_air_mi2_01_wreck"
		deleteVehicle _sct_hel_obj;
		_sct_wreck="vn_air_mi2_01_wreck" createVehicle _pos;
		_sct_wreck addAction
		[ 
			"Search", 
			"search_scout_wreck.sqf", 
			nil, 
			1.5, 
			true, 
			true, 
			"", 
			"true", 
			10, 
			false, 
			"", 
			""
		];
		break;
	};
};


