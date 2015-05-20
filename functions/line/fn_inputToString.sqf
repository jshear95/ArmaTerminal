/*
 *	Joshua Shear
 *	Line_fnc_inputToString.sqf
 *	Takes in an array of input and returns the input as a string
 *	
 *	How to call : [char array] call Line_fnc_inputToString;
 *	
 *	Returns : String
 *	
 *	Function calls :
 *		NONE
 */
 
private[_input,_output];

_input = _this select 0;

_output = "";

{
	_output = _output + _x;
}forEach _input;

_output;