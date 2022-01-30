if (isServer) then {
	[] spawn compileFinal preprocessFileLineNumbers "classnames.sqf";
	//[] spawn compileFinal preprocessFileLineNumbers "init\db_init.sqf";
	[] spawn compileFinal preprocessFileLineNumbers "init\start_game.sqf";
};
if (hasInterface) then {
	ARKOV_player_status = 0;
	[] spawn compileFinal preprocessFileLineNumbers "init\area_restriction.sqf";
};