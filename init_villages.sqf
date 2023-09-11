villages = [
    "village",
    "village_1",
    "village_2",
    "village_3",
    "village_4",
    "village_5",
    "village_6",
    "village_7",
    "village_8",
    "village_9",
    "village_10",
    "village_11",
    "village_12",
    "village_13",
    "village_14",
    "village_15",
    "village_16",
    "village_17",
    "village_18",
    "village_19",
    "village_20",
    "village_21",
    "village_22",
    "village_23",
    "village_24",
    "village_25",
    "village_26",
    "village_27",
    "village_28",
    "village_29",
    "village_30",
    "village_31",
    "village_32",
    "village_33",
    "village_34",
    "village_35",
    "village_36",
    "village_37",
    "village_38",
    "village_39",
    "village_40",
    "village_41",
    "village_42",
    "village_43",
    "village_44",
    "village_45",
    "village_46",
    "village_47",
    "village_48",
    "village_49",
    "village_50",
    "village_51",
    "village_52",
    "village_53",
    "village_54",
    "village_55",
    "village_56",
    "village_57",
    "village_58",
    "village_59",
    "village_60",
    "village_61",
    "village_62",
    "village_63",
    "village_64",
    "village_65",
    "village_66",
    "village_67",
    "village_68",
    "village_69",
    "village_70",
    "village_71",
    "village_72",
    "village_73",
    "village_74",
    "village_75",
    "village_76",
    "village_77",
    "village_78",
    "village_79",
    "village_80",
    "village_81",
    "village_82",
    "village_83",
    "village_84",
    "village_85",
    "village_86",
    "village_87",
    "village_88",
    "village_89",
    "village_90",
    "village_91",
    "village_92",
    "village_93",
    "village_94",
    "village_95",
    "village_96",
    "village_97",
    "village_98",
    "village_99",
    "village_100",
    "village_101",
    "village_102",
    "village_103",
    "village_104",
    "village_105",
    "village_106",
    "village_107",
    "village_108",
    "village_109",
    "village_110",
    "village_111",
    "village_112",
    "village_113",
    "village_114",
    "village_115",
    "village_116",
    "village_117",
    "village_118",
    "village_119",
    "village_120",
    "village_121",
    "village_122",
    "village_123",
    "village_124",
    "village_125",
    "village_126",
    "village_127",
    "village_128",
    "village_129",
    "village_130",
    "village_131"
];

village_guard = ["vn_o_men_vc_regional_09", 
"vn_o_men_vc_regional_12", 
"vn_o_men_vc_regional_02", 
"vn_o_men_vc_regional_03", 
"vn_o_men_vc_regional_08", 
"vn_o_men_vc_local_12", 
"vn_o_men_vc_local_26"
];

_vehicles_civ = ["vn_c_car_03_01", 
"vn_c_car_01_01", 
"vn_c_car_04_01", 
"vn_c_car_02_01", 
"vn_c_wheeled_m151_02", 
"vn_c_wheeled_m151_01", 
"vn_c_car_01_02", 
"vn_b_wheeled_m54_01_aus_army", 
"vn_b_wheeled_m151_01", 
"vn_c_bicycle_01"];

village_positions_3d = [];

add_elder_action = {
    params["_e"];
    _e = _this select 0;
    _e addAction ["Talk", "talk_to_elder.sqf"];
};

_elder = "vn_c_men_04";

{
	_pos = getMarkerPos _x;
	_pos_3d = [_pos select 0, _pos select 1, 0];
	village_positions_3d pushBack [_pos_3d,false];
}forEach villages;
village_groups = [];
active_villages = [];
//spawn if people close
while {true} do{
	sleep 1;
	_index = 0;
	{
		_plr = _x;
		{
			_village = _x select 0;
			_active = _x select 1;
			if(_plr distance _village < 1000 && !_active) then{
				//create elder:
				_grp = createGroup civilian;
				_e = _grp createUnit[_elder,_village,[],0,"FORM"];
                _x_ = _village select 0;
                _y_ = _village select 1;
                if(round(random(2))==1) then {
                    createVehicle[selectRandom _vehicles_civ, [_x_+5,_y_+5,0]];
                };
                [_e] remoteExec["add_elder_action",0,true];
				//_e addAction ["Talk", "talk_to_elder.sqf"];
				_grp setBehaviour "CARELESS";
				village_positions_3d set[_index, [_village,true]];
				//create enemies:
                if(round(random(4))<=2)then{
                    village_groups pushBack createGroup EAST;
                    _current_enemy_group = count(village_groups)-1;
                    _x_ = _village select 0;
                    _y_ = _village select 1;
                    {
                        _rand1 = random[-100,0,100];
                        _rand2 = random[-100,0,100];
                        _x_coord = _x_ + _rand1;
                        _y_coord = _y_ + _rand1;
                        _x createUnit [[_x_coord,_y_coord,0],village_groups select(_current_enemy_group)];
                    }forEach village_guard;
                    _wpnt = village_groups select(_current_enemy_group) addWaypoint[_village,100];
                    _wpnt = village_groups select(_current_enemy_group) addWaypoint[_village,100];
                    _wpnt = village_groups select(_current_enemy_group) addWaypoint[_village,100];
                    _wpnt setWaypointType "CYCLE";
                    village_groups select(_current_enemy_group) setBehaviour "SAFE";
                };
				//add to active village list so we can monitor them
				//active_villages pushBack _village;
			};
			_index = _index + 1;
		}forEach village_positions_3d;
	}forEach allPlayers;
};