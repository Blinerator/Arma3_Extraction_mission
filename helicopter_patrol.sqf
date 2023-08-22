
helicopter_patrol addWaypoint[getPos downed_0,1000];
helicopter_patrol addWaypoint[getPos downed_0,1000];

helicopter_patrol addEventHandler ["WaypointComplete",{
	helicopter_patrol addWaypoint[getPos downed_0,1000];
}];

// while {true} do{
// 	_oldWaypoint = helicopter_patrol addWaypoint[getPos downed_0,1000];

// 	_waypointReachedEventHandler = _oldWaypoint addWaypointReachedEventHandler {
// 		_oldWaypoint = helicopter_patrol addWaypoint[getPos downed_0,1000];
// 	}
// };