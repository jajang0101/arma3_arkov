if (isNil "ARKOV_sector") exitWith {systemChat "Wait for the game to be ready."};
_all = (nearestObjects [getMarkerPos ARKOV_sector, ["House", "Building"], ARKOV_sector_size]) select {(count (_x buildingPos -1)) > 0};
private "_result";
_iteration = 0;
while {(isNil "_result")  && (_iteration < 1000)} do {
	_iteration = _iteration + 1;
	_building = selectRandom _all;
	if (count (allUnits select {((_x distance (getPos _building)) < 200) && (((isPlayer _x) && (group _x != group player)) || (side _x == east))}) > 0) then {
		_all = _all - [_building];
	} else {
		_result = _building;
	};
};
if (isNil "_result") exitWith {hint "failed to find deploy position. try again later."};
cutText ["Deploying", "BLACK FADED", 2];
sleep 3;
player setPos (selectRandom (_result buildingPos -1));
ARKOV_player_status = 1;
cutText ["", "BLACK IN", 2];