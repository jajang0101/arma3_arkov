systemChat "게임이 종료됐습니다. 1분 후에 새 게임이 시작됩니다.";
if (ARKOV_player_status == 1) then {
	player addACtion ["베이스로 돌아가기", {[] spawn ARKOV_fnc_deployToBase}];
};
