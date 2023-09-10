_pos = _this select 0;
_patrol_area = 250;
_patrol_groups = [];
x = _pos select 0;
y = _pos select 1;

_loc1 =  [x + random[100,_patrol_area/2,_patrol_area],y + random[100,_patrol_area/2,_patrol_area]];
_loc2 =  [x - random[100,_patrol_area/2,_patrol_area],y - random[100,_patrol_area/2,_patrol_area]];
_loc3 =  [x + random[100,_patrol_area/2,_patrol_area],y - random[100,_patrol_area/2,_patrol_area]];
_loc4 =  [x - random[100,_patrol_area/2,_patrol_area],y + random[100,_patrol_area/2,_patrol_area]];

_spawn_locs = [_loc1, _loc2, _loc3, _loc4];

for "_i" from 0 to 3 do{
	_patrol_groups pushBack createGroup EAST;
	{
		_x createUnit [_spawn_locs select _i,_patrol_groups select _i];
	}forEach patrol_group;
};

{
	_wp = _x addWaypoint[_pos,50];
}forEach _patrol_groups;