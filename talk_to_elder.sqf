//Alpha 1-1 is downed team
//Alpha 1-2 is rescue team

_activation_unit = _this select 1;
_activation_group = group _activation_unit;
//downed:
if(groupId _activation_group == "Alpha 1-1") then{
	_num_events_0 = 8;
	_dice_roll_0 = round(random(_num_events_0-1));

	if(count already_occured_elder_event_downed == _num_events_0) then {
		if (groupId (group player) != "Alpha 1-2") then {
				hint "Go away";
		}forEach allPlayers;
	};
	_cnt = 0;
	while {_dice_roll_0 in already_occured_elder_event_downed} do{
		_dice_roll_0 = round(random(_num_events_0-1));
		_cnt = _cnt+1;
		if(_cnt>1000)then{
			break;
		}
	};

	already_occured_elder_event_downed pushBack _dice_roll_0;


	if(_dice_roll_0 == 0) then{
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "Leave!  Here's a radio, if it'll make you go faster.";
			};
		}forEach allPlayers;

		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_b_item_radio_urc10",1];
	};

	if(_dice_roll_0 == 1) then{
		[getPos _activation_unit] execVM "ambush.sqf";
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "They're offering a reward for you... Don't move!";
			};
		}forEach allPlayers;
	};

	if(_dice_roll_0 == 2) then{
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "You want to know where you are?  I'll tell you, but only once!";
				sleep 4;
				_pos = getPos _activation_unit;
				hint format["%1,%2",_pos select 0, _pos select 1];
			};
		}forEach allPlayers;
	};

	if(_dice_roll_0 == 3) then{
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "Leave!  Here's a radio, if it'll make you go faster.";
			};
		}forEach allPlayers;
		
		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_b_item_radio_urc10",1];
	};

	if(_dice_roll_0 == 4) then{
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "Leave!  Here's a map, if it'll make you go faster.";
			};
		}forEach allPlayers;
		
		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_o_item_map",1];
	};

	if(_dice_roll_0 == 5) then{
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "Leave!  Found this on a dead soldier. You can have it, if it makes you go faster.";
			};
		}forEach allPlayers;

		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_k98k_mrk",1];
		_crate addItemCargoGlobal ["vn_k98k_mag",10];
	};

	if(_dice_roll_0 == 6) then{
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "Your people killed my wife and kids, rot in hell";
			};
		}forEach allPlayers;
		_grenade = "vn_m61_grenade_ammo" createVehicle getPos(_this select 0);
		_grenade setDamage 1;
	};

	if(_dice_roll_0 == 7) then{
		{
		if (groupId (group player) != "Alpha 1-2") then {
				hint "Leave! Found this on a dead soldier. You can have it, if it makes you go faster.";
			};
		}forEach allPlayers;

		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_rpg7",1];
		_crate addItemCargoGlobal ["vn_rpg7_mag",5];
	};

}
else
{
	_num_events = 9;
	_dice_roll = round(random(_num_events-1));

	// if(count already_occured_elder_event_rescue == _num_events) then {
	// 	already_occured_elder_event_rescue deleteRange [0,_num_events+1];
	// };

	while {_dice_roll in already_occured_elder_event_rescue} do{
		_dice_roll = round(random(_num_events-1));
	};

	already_occured_elder_event_rescue pushBack _dice_roll;
	
	//Option 1, Ambush:
	if(_dice_roll == 1) then{
		[getPos _activation_unit] execVM "ambush.sqf";
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint "Sorry, I don't know anything.  Stick around though, my friends might be able to help.";
			};
		}forEach allPlayers;
	};

	//Option 2, Crash site:
	if(_dice_roll == 0) then{
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint format["I heard about a crash at grid %1,%2",round((spawnPosition select 0)),round((spawnPosition select 1))];
			};
		}forEach allPlayers;
	};

	//Option 3, Suicide Bomber:
	if(_dice_roll == 2) then{
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint "Your people killed my wife and kids, rot in hell";
			};
		}forEach allPlayers;
		_grenade = "vn_m61_grenade_ammo" createVehicle getPos(_this select 0);
		_grenade setDamage 1;
	};

	//Option 4, doesn't know anything:
	if(_dice_roll == 3) then{
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint "Sorry, I don't know anything.";
			};
		}forEach allPlayers;
	};

	//Option 5, mortars:
	if(_dice_roll == 4) then{
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint"They have my children... We're here as bait... Watch out for mortar shells!";
			};
		}forEach allPlayers;
		_pos = getPos _activation_unit;
		sleep 15;
		[[_pos select 0, _pos select 1, 0],"vn_shell_60mm_m49a2_he_ammo",250,25,5] spawn BIS_fnc_fireSupportVirtual;
	};

	if(_dice_roll == 5) then{
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint "Leave!  Found this on a dead soldier. You can have it, if it makes you go faster.";
			};
		}forEach allPlayers;

		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_k98k_mrk",1];
		_crate addItemCargoGlobal ["vn_k98k_mag",10];
	};

	if(_dice_roll == 6) then{
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint "Leave! Found this on a dead soldier. You can have it, if it makes you go faster.";
			};
		}forEach allPlayers;

		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_sa7b",1];
		_crate addItemCargoGlobal ["vn_sa7b_mag",2];
	};
	//vn_rpg7
	if(_dice_roll == 7) then{
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint "Leave! Found this on a dead soldier. You can have it, if it makes you go faster.";
			};
		}forEach allPlayers;

		_crate = "vn_b_ammobox_04" createVehicle getPos(_this select 0);
		_crate addItemCargoGlobal ["vn_rpg7",1];
		_crate addItemCargoGlobal ["vn_rpg7_mag",5];
	};

	if(_dice_roll == 8) then{
		[getPos _activation_unit] execVM "scout_helicopter.sqf";
		{
		if (groupId (group player) != "Alpha 1-1") then {
				hint "I don't know where the crash is, but I know the patrol route of a VC scout helicopter.  I'll mark it on your map.";
			};
		}forEach allPlayers;
	};
};
_this select 0 removeaction (_this select 2);
_this select 0 addAction ["Talk","already_interacted_elder.sqf"];