_p = _this select 1;
_target = _this select 0;
_pos = getPos _target;
x = round (_pos select 0);
y = round (_pos select 1);
msg = format["%1,%2",x,y];
msg = "Radio Transmission: " + msg;
[msg] remoteExec ["hint",0];
[_pos] execVM "rt_recap.sqf";




// _remoteCode = {
// 	params["_msg"];

// 	hint "AAAAAAAAAAAAAAAAA";
// 	[
// 		[
// 			["Radio Transmission:", "<t align = 'center' shadow = '1' size = '0.7' font='PuristaBold'>%1</t>"],
// 			[_msg, "<t align = 'center' shadow = '1' size = '0.7'>%1</t><br/>"],
// 			["", "<t align = 'center' shadow = '1' size = '1.0'>%1</t>", 15]
// 		]
// 	] spawn BIS_fnc_typeText;
// };

// [msg] remoteExec ["_remoteCode",0];