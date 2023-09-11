sleep 15;//wait for other scripts to finish;
while {true} do{
	//do continually so new spawned enemies don't have.
	{
		_fml = isFormationLeader _x;
		//hint format["%1",side _x != "west"];
		if((side _x != west) && !_fml) then {
			_x unassignItem "vn_o_item_radio_m252";
			_x removeItem "vn_o_item_radio_m252";
			_x unassignItem "vn_o_item_map";
			_x removeItem "vn_o_item_map";
			_x unassignItem "vn_b_item_compass";
			_x removeItem "vn_b_item_compass";
		};
		if(side _x == civilian) then{
			_x unassignItem "vn_o_item_radio_m252";
			_x removeItem "vn_o_item_radio_m252";
			_x unassignItem "vn_o_item_map";
			_x removeItem "vn_o_item_map";
			_x unassignItem "vn_b_item_compass";
			_x removeItem "vn_b_item_compass";
		};
	}forEach allUnits;
	sleep 10;
};