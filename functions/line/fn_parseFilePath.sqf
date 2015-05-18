/*
 *	Joshua Shear
 *	Line_fnc_parseFilePath.sqf
 *	Takes in the current file path and returns the parsed version for the new lines pre text
 */
 
private[_filePath,_output];

_filePath = _this select 0;

_output = "";

{
	if(_x == "MASTER")then{
		_output = _output + _x;
	}else{
		_output = _output + "/" + _x;
	};	
}forEach _filePath;

_output = _output + " : ";

_output;