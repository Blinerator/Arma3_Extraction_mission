_pos = _this select 0;
_patrol_area = 500;
_patrol_groups = [];

x = _pos select 0;
y = _pos select 1;
x = x + random(2*_patrol_area) - _patrol_area/2;
y = y + random(2*_patrol_area) - _patrol_area/2;
_veh = createVehicle["vn_o_wheeled_z157_mg_02",[x,y,1],[],0,"NONE"];
createVehicleCrew _veh;
_grp = group _veh;
_grp addWaypoint[_pos,50];

x = _pos select 0;
y = _pos select 1;
x = x + random(2*_patrol_area) - _patrol_area/2;
y = y + random(2*_patrol_area) - _patrol_area/2;
_veh = createVehicle["vn_o_wheeled_z157_mg_01_nva65",[x,y,1],[],0,"NONE"];
createVehicleCrew _veh;
_grp = group _veh;
_grp addWaypoint[_pos,50];


for "_i" from 0 to 6 do{
	x = _pos select 0;
	y = _pos select 1;
	x = x + random(2*_patrol_area) - _patrol_area/2;
	y = y + random(2*_patrol_area) - _patrol_area/2;
	_patrol_groups pushBack createGroup EAST;
	patrol_group_leader createUnit [[x,y,1],_patrol_groups select _i];
	{
		_x createUnit [[x,y,0],_patrol_groups select _i];
	}forEach patrol_group;
};

{
	_wp = _x addWaypoint[_pos,50];
}forEach _patrol_groups;
x = _pos select 0;
y = _pos select 1;



sleep 10;
["Transmission intercepted, VC forces imbound!"] remoteExec ["hint",0];
sleep 10;
if(alive a1) then {
	[[x,y,0],"vn_shell_60mm_m49a2_he_ammo",250,100,10] spawn BIS_fnc_fireSupportVirtual;
};