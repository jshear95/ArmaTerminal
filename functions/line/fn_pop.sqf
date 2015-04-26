/**
	Pops the top char on the stack and returns it
*/

private ["_stack"];
_stack = _this select 0;

_val = _stack select (count _stack - 1);

_stack set [count _stack - 1 , "" ];
_stack = _stack - [""];

_val;