if (!hasInterface) exitWith {};
ARKOV_player_status = 0;
_timer = 0;
//_marker = createMarker ["nomarker", getMarkerPos ARKOV_sector];
//_marker setMarkerType "hd_dot";
while {true} do {
    sleep 1;
    if (ARKOV_player_status == 0) then {
        if (((getPos player) distance2D (getMarkerPos "ARKOV_base")) > 500) then {
            _timer = _timer + 1;
            systemChat ("Return to the base area, or you will be killed in " + str (5 - _timer) + " seconds");

        } else {
            _timer = 0;
        };
    } else {
        if (((getPos player) distance2D (getMarkerPos ARKOV_sector)) > ARKOV_sector_size) then {
            _timer = _timer + 1;
            systemChat ("Return to the combat area, or you will be killed in " + str (5 - _timer) + " seconds");
        } else {
            _timer = 0;
        };
    };
    if (_timer > 5) then { 
        player setDamage 1;
        _timer = 0;
    };
};