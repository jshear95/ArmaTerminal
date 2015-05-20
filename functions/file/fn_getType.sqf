/*
 *	Joshua Shear
 *	File_fnc_getType.sqf
 *	Takes in a file and returns a boolean weather or not the file is a directory or not
 *	
 *	How to call : [file] call File_fnc_getType;
 *	
 *	Returns : boolean as to weather or not the file is a directory or not
 *	
 *	Function calls :
 *		NONE
 */
 
private[_file,_bool];

_file = _this select 0;
_bool = false;

if(count (_file select 1) > 0)then{
	if(typeName(_file select 1 select 0) == "ARRAY" || str(_file select 1) == str([]))then{
		_bool = true;
	};
}else{
	_bool = true;
};

_bool;