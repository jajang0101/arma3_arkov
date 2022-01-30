TARKOV_fnc_db = ["new", "arkov"] call OO_INIDBI;

addMissionEventHandler ["PlayerConnected",
{
	params ["_id", "_uid", "_name", "_jip", "_owner"];
    private "_inv";
    _inv = ["read", [_uid, "ARKOV_inventory"]] call TARKOV_fnc_db;
    if (!_inv) then {
        _inv = [];
    };
    [_inv] remoteExec ["ARKOV_fnc_addInventory", _owner];
}];