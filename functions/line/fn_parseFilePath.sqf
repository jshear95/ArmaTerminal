/*
 *	Joshua Shear
 *	Line_fnc_parseFilePath.sqf
 *	Takes in the current file path and returns the parsed version for the new lines pre text
 *	
 *	How to call : [file path] call Line_fnc_parseFilePath;
 *	
 *	Returns : string form of file path
 *	
 *	Function calls:
 *		NONE
 */
 
private _filePath = _this select 0;

private _output = "";

{
	if(_x == "MASTER")then{
		_output = _output + _x;
	}else{
		_output = _output + "/" + _x;
	};	
}forEach _filePath;

_output = _output + " : ";

_output;