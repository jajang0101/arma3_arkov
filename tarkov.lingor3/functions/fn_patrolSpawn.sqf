while {!isNil "ARKOV_sector"} do {
	if (random 2 < 1) then {
		_allunits = allUnits select {(_x distance (getMarkerPos ARKOV_sector)) < ARKOV_sector_size + 100};
		if ((count _allunits) < 60) then {
			_comp = selectRandom ARKOV_OPFOR_patrol;
			_grp = createGroup east;
			_pos = [getMarkerPos ARKOV_sector, (ARKOV_sector_size - 200), (ARKOV_sector_size + 80), 0, 1, true, 100, false] call ARKOV_fnc_findSafePos;
			for [{_i = 0}, {_i < count _comp}, {_i = _i + 1}] do {
				_grp createUnit [_comp # _i, _pos, [], 0, "NONE"];
			};
			_wp = _grp addWaypoint [getMarkerPos (selectRandom ARKOV_escapes), 0];
			_wp setWaypointType "MOVE";
		};
	};
	sleep 60;
};
