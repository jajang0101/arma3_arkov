_all_sectors = [];
_all_escapes = [];
{	
	_tempMkr = toArray _x;
	_tempMkr resize 13;
	if (toString _tempMkr == "ARKOV_sector_") then {
		_all_sectors pushBack _x;
	};
	if (toString _tempMkr == "ARKOV_escape_") then {
		_all_escapes pushBack _x;
	};
	
} forEach allMapMarkers;
[_all_sectors, _all_escapes] spawn ARKOV_fnc_createSector;

//_timer = 2700;
_timer = 30;
while {true} do {
    sleep  1;

	if (_timer == 0) then {
		//end the game
		[] remoteExec ["ARKOV_fnc_player_endGame", -2, false];
		{if ((!isPlayer _x) && ((_x distance (getMarkerPos ARKOV_sector)) < ARKOV_sector_size + 100)) then {
			deleteVehicle _x;
		};} forEach (allMissionObjects "");
		ARKOV_sector setMarkerAlpha 0;
		ARKOV_sector = nil;
		publicvariable "ARKOV_sector";
		for [{_i = 0}, {_i < count ARKOV_escapes}, {_i = _i + 1}] do {
			deleteMarker (ARKOV_escapes # _i);
		};
		sleep 60;
		[_all_sectors, _all_escapes] spawn ARKOV_fnc_createSector;
		_timer = 2700;
	} else {
		if ((_timer % 600) == 0) then {
		[(str (_timer / 60)) + "분 후에 게임이 종료됩니다."] remoteExec ["systemChat", 0, false];
	} else {
		if (_timer <= 300) then {
			if (_timer % 60 == 0) then {
				[(str(_timer / 60)) + "분 후에 게임이 종료됩니다."] remoteExec ["systemChat", 0, false];
			} else {
				if (_timer <= 20) then {
					[(str _timer) + "초 후에 게임이 종료됩니다."] remoteExec ["systemChat", 0, false];
				};
			};
		};
	};
		_timer = _timer - 1;
	};

};