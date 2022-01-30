params ["_all_sectors", "_all_escapes"];


ARKOV_sector = selectRandom _all_sectors;
ARKOV_sector_size = (getMarkerSize ARKOV_sector) select 0;
ARKOV_sector setMarkerAlpha 1;
_all_escapes = _all_escapes select {((getMarkerPos _x) distance (getMarkerPos ARKOV_sector)) < ARKOV_sector_size};

for [{_i = 0}, {_i < count _all_sectors}, {_i = _i + 1}] do {
	_sector = _all_sectors select _i;
	if (_sector != ARKOV_sector) then {
		_sector setMarkerAlpha 0;
	};
};

_all_buildings = (nearestObjects [getMarkerPos ARKOV_sector, ["House", "Building"], ARKOV_sector_size]) select {count (_x buildingPos -1) > 0};
for [{_i = 0}, {_i < count _all_buildings}, {_i = _i + 1}] do {
	_buildingPoses = (_all_buildings select _i) buildingPos -1;
	_bPosCount = count _buildingPoses;
	if ((random 20) < 3) then {
		_grp = createGroup east;
		for [{_i0 = 0}, {_i0 < ((count _buildingPoses) / 10)}, {_i0 = _i0 + 1}] do {
			//spawn an infantry
			_type = selectRAndom ARKOV_OPFOR_infantry;
			_unit = _grp createUnit [_type # 0, selectRandom _buildingPoses, [], 0, "NONE"];
			doStop _unit;
		};
	};
	
	for [{_i1 = 0}, {_i1 < _bPosCount}, {_i1 = _i1 + 1}] do {
		if (random 20 < 5) then {
			_pos = selectRandom _buildingposes;
			_crate = "GroundWeaponHolder" createvehicle _pos;
			_crate setPosATL _pos;
			if (random 4 < 1) then {
				//spawn weapons
				_weap = selectRandom ARKOV_items_weapons;
				_crate addWEaponCargoGlobal [_weap #0, 1];
				_mag = (getArray (configfile >> "CfgWeapons" >> (_weap # 0) >> "magazines")) # 0;
				_crate addMagazineCargoGlobal [_mag, (2 + round (random 4))];
				if (count (_weap # 1) > 0) then {
					{_crate addItemCargoGlobal [_x, 1]} forEach (_weap # 1);
				};
				if (random 2 > 1) then {
					_crate addItemCArgoGlobal [selectRandom ARKOV_items_attachments, 1];
				};
			} else {
				if (random 3 < 1) then {
					_crate addItemCArgoGlobal [selectRandom ARKOV_items_attachments, 1];
					if (random 4 < 1) then {
						_crate addItemCArgoGlobal [selectRandom ARKOV_items_misc, 1];
					};
					if (random 4 < 1) then {
						_crate addItemCArgoGlobal [selectRandom ARKOV_items_misc, 1];
					};
				} else {
					if (random 2 >1) then {
						_medItemCount = 1 + round (random 4);
						for [{_i2 = 0}, {_i2 < _medItemCount}, {_i2 = _i2 + 1}] do {
							_crate addItemCArgoGlobal [selectRandom ARKOV_items_medic, 1];
						};
					};
					if (random 2 > 1) then {
						_crate addItemCArgoGlobal [selectRandom ARKOV_items_misc, 1];
					};
				};
				if (random 3 < 2) then {
					_crate addItemCArgoGlobal [selectRandom ARKOV_items_vest, 1];
				};
				if (random 3 < 2) then {
					_crate addItemCArgoGlobal [selectRandom ARKOV_items_helmet, 1];
				};
				if (random 3 < 2) then {
					_crate addBackPackCargo [selectRandom ARKOV_items_backPack, 1];
				};
			};
			
		};
	};
};

ARKOV_escapes = [];
for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do {
	_mkr = selectRandom _all_escapes;
	_newMkr = createMarker ["ARKOV_escape", getMarkerPos _mkr];
	ARKOV_escapes pushBack _newMkr;
	_newMkr setMarkerType "mil_marker";

	_dir = random 360;
	_container = "Land_Cargo20_grey_F" createVehicle (getMArkerPos _mkr);
	_container allowDamage false;
	_container setDir _dir;
	_terminal = createVehicle ["Land_DataTerminal_01_F", getMarkerPos _mkr, [], 0, "CAN_COLLIDE"];
	_terminal setDir _dir;
	_terminal allowDamage false;
	[_terminal, 1] spawn BIS_fnc_dataTerminalAnimate;
	if (_i == 0) then {
		ARKOV_realTerminal = _terminal;
		publicVariable "ARKOV_realTerminal";
	};

	[
    _terminal,                                                                        
    "<t size='1.5' shadow='2' color='#2EFEF7'>Escape</t>",                                                                      
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",                   
    "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_hack_ca.paa",                   
    "true",                                                      
    "true",                                                   
    {(_this select 1) sidechat "Trying to escape...";},                                                                         
    {},                                                                                
    {[_this select 0] spawn ARKOV_fnc_escape;},                                              
    {},                                                                               
    [],                                                                                
    10,                                                                                
    0,                                                                                 
    true,                                                                              
    false                                                                          
	] remoteExec ["BIS_fnc_holdActionAdd",0,_terminal];
};

publicVariable "ARKOV_sector";
publicVariable "ARKOV_sector_size";
[] spawn ARKOV_fnc_patrolSpawn;