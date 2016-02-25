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

private _input = _this select 0;
private _output = "";

if(str(_this) != "[<null>]")then{	//Prevents erroneous input from making error message
	{
		_output = _output + _x;
	}forEach _input;
};
_output;