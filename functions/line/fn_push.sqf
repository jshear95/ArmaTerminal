/**
	Pushes the item to the top of the stack
*/

private ["_stack","_item"];
_stack = _this select 0;
_item = _this select 1;
_stack set [count _stack, _item ];

