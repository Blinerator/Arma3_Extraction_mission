sleep 10;	
_cnt = 0;
while{true} do{
	initial_patrol addWaypoint[getPos downed_0, 10];
	_cnt = _cnt + 1;
	sleep 30;
	if(_cnt>10) then {
		break;
	};
};
