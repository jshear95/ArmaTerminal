/*
 *	Joshua Shear
 *	Computer_fnc_changeLineCount.sqf
 *	Takes in an int value of how many lines there are and sets either the command line or steeds line count variable to that value.
 *  If -1 passed in, it will set the line count to 0
 *	
 *	How to call : [int,commandLine/STEED] call Computer_fnc_changeLineCount.sqf
 *	
 *	Returns: nothing
 *	
 *	Function calls :
 *		None
 */
 
 private _int = _this select 0;
 private _obj = _this select 1;
 
 if(_obj select 7 == true or _obj select 7 == false)then{		//Only the commandLine has a boolean at index 7
	if(_int == -1)then{
		_obj set[8, 0];
	}else{
		_obj set[8, _int];
	};
 }else{
	if(_int == -1)then{
		_obj set[7, 0];
	}else{
		_obj set[7, _int];
	};
};