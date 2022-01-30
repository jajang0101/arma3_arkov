params ["_pos", "_minDist", "_maxDist", "_radius", "_grad", "_isWater", "_playerDist", "_inSector"];
if (isNil "_radius") then {
	_radius = 0;
};
if (isNil "_grad") then {
	_grad = 1;
};

_water = -1;
if (isNil "_isWater") then {
	switch (_isWater) do {
	case true: {
		_water = 0
	};
	case false: {
		_water = 1;
	};
	};
};
if (isNil "_playerDist") then {
	_playerDist = 0;
};
if (isNil "_inSector") then {
	_inSector = true;
};

private "_result";
_iteration = 0;
while {isNil "_result"} do {
	if (_iteration > 5000) exitWith {["failed to find a position"] remoteExec ["systemChat", 0, false];};
	_iteration = _iteration + 1;
	_dist = _minDist + random (_maxDist - _minDist);
	_relPos = _pos getPos [_dist, random 360];
	_players = allUnits select {(_x distance _relPos) < _playerDist};
	if (_inSector) then {
		if (((_relPos distance (getMarkerPos ARKOV_sector)) < ARKOV_sector_size) && !((_relPos isFlatEmpty [_radius, -1, _grad, _radius * 0.5, _water]) isEqualTo []) && (count _players == 0)) then {
		_result = _relPos;
		};
	} else {
		if (!((_relPos isFlatEmpty [_radius, -1, _grad, _radius * 0.5, _water]) isEqualTo [])&& (count _players == 0)) then {
		_result = _relPos;
		};
	};
	
};

_result;