
_weapons = [["vn_m1911_sd","vn_m1911_mag"],["vn_m1895_sd","vn_m1895_mag"],["vn_m10_sd","vn_m10_mag"],["vn_mc10_sd","vn_mc10_mag"],["vn_mpu_sd","vn_mpu_mag"],["vn_p38_sd","vn_p38_mag"],["vn_hp_sd","vn_hp_mag"],["vn_l34a1","vn_f1_smg_mag"],["vn_izh54_p","vn_izh54_so_mag"],["vn_welrod","vn_welrod_mag"],["vn_m79_p","vn_40mm_m406_he_mag"]];
//_magazines = ["vn_m1911_mag","vn_m1895_mag","vn_m10_mag","vn_mc10_mag","vn_mpu_mag","vn_p38_mag","vn_hp_mag","vn_f1_smg_mag","vn_izh54_so_mag","vn_welrod_mag","vn_40mm_m406_he_mag"];

spawn_crate setPos [spawnPosition select 0,spawnPosition select 1,100];
spawn_crate addItemCargoGlobal ["ACE_EntrenchingTool",2];
spawn_crate addItemCargoGlobal ["vn_mx991_red",3];
//spawn weapon for each dude:

_wpn = selectRandom _weapons;
spawn_crate addItemCargoGlobal [_wpn select 0,1];
spawn_crate addItemCargoGlobal [_wpn select 1,3];
_wpn = selectRandom _weapons;
spawn_crate addItemCargoGlobal [_wpn select 0,1];
spawn_crate addItemCargoGlobal [_wpn select 1,3];
_wpn = selectRandom _weapons;
spawn_crate addItemCargoGlobal [_wpn select 0,1];
spawn_crate addItemCargoGlobal [_wpn select 1,3];


_parachute = createVehicle ["B_Parachute_02_F", [spawnPosition select 0,spawnPosition select 1,100], [], 0, 'FLY'];
spawn_crate attachTo [_parachute, [0,0,-1.3]];
spawn_crate allowdamage false;

sleep 15;
_smk = createVehicle ["SmokeShellGreen", position spawn_crate, [], 0, "NONE"];
_smk attachTo [spawn_crate,[0,0,.2]];
sleep 30;
_smk = createVehicle ["SmokeShellGreen", position spawn_crate, [], 0, "NONE"];
_smk attachTo [spawn_crate,[0,0,.2]];