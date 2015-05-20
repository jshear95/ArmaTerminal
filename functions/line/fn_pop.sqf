/*
 *	Joshua Shear
 *	Line_fnc_pop.sqf
 *	Takes in a stack and attempts to remove the top element on the stack before returning it
 *	
 *	How to call: [stack] call Line_fnc_pop.sqf
 *	
 *	Returns : value at the top of the stack
 *	
 *	Function calls :
 *		NONE
*/

private [_stack,_val];
_stack = _this select 0;

_val = _stack select (count _stack - 1);

_stack set [count _stack - 1 , "" ];
_stack = _stack - [""];

_val;