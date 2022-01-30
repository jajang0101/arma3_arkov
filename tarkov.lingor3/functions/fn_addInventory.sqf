params ["_items"];
if (isNil "ARKOV_inveytoryCrate") then {
	_obj = "B_supplyCrate_F" createVehicleLocal (getPos ARKOV_inventoryPos);
	_obj allowDamage false;
	hideObject _obj;
	clearBackpackCargo _obj;
	clearItemCargo _obj;
	ARKOV_inventoryCrate = _obj;
	_obj addEventHandler ["ContainerClosed", {
		params ["_container", "_unit"];
		_itemSave = (itemCargo _container) append (backpackCargo _container);
		[getPlayerUID player, "ARKOV_inventory", _itemSave] remoteExec ["ARKOV_fnc_db_save",2, false];
		_container setPos (getPos ARKOV_inventoryPos);
	}];
	player addEventHandler ["Take", {
		params ["_unit", "_container", "_item"];
		if ((_container == ARKOV_inventoryCrate) && (ARKOV_player_status == 0)) then {
			if (_item isKindOf "Bag_Base") then {
				removeBackpackGlobal player;
				_container addBackpackCargo _item;
			} else {
				player removeItem _item;
				_container addItemCargo _item;
			};
			systemChat "베이스에서 아이템을 꺼낼 수 없습니다.";
		};
	}];
};

for [{_i = 0}, {_i < count _items}, {_i = _i + 1}] do {
	_item = _items # _i;
	if (_item isKindOf "Bag_Base") then {
		_obj addBackpackCargo _item;
	} else {
		_obj addItemCargo _item;
	};
};

