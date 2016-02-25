/*
 *	Joshua Shear
 *	File_fnc_hasWritePermission.sqf
 *	takes in a file and the current user, then compares the file permission with the current user to see if they have write permission
 *	
 *	How to call : [file,current user] call File_fnc_hasWritePermission.sqf
 *	
 *	Returns: a boolean
 *	
 *	Function calls :
 *		None
 */
 
private _file = _this select 0;
private _user = _this select 1;
private _output = false;
if(count str(_file) > 2)then{
	private _permission = _file select 3;
	
	switch(true)do{
		case(str(_user) == str("PUBLIC") and ((_permission select 2)%4 > 1)):{_output = true;};				//Checks public permission
		case(str(_user) == str(_file select 2) and ((_permission select 0)%4 > 1)):{_output = true;};		//Checks owner permission
		case((_permission select 1)%4 > 1):{_output = true;};												//Checks user permission
	};
};
if(_user == "admin")then{																				//Gives permission to admin
	_output = true;
};
_output
