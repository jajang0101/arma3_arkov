_terminal = _this select 0;
if (_terminal == ARKOV_realTerminal) then {
	publicVariable "ARKOV_escapers";
	cutText ["You escaped!","BLACK",2];
	cutText ["","BLACK IN",2];
	player setPos (getMarkerPos "ARKOV_base");
	ARKOV_player_status = 0;
} else {
	systemChat "Failed to escape. Try finding another escpae.";
};