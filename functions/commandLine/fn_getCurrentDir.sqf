/*
 *	Joshua Shear
 *	CommandLine_fnc_getCurrentDir.sqf
 *	Takes in a file system and file path.
 *	Walks through the file path until it reaches the current open directory
 *	Returns the current open directory
 *	
 *	How to call : [File structure, file path] call CommandLine_fnc_getCurrentDir;
 *	
 *	Returns : The current directory
 *	
 *	Function Calls :
 *		File_fnc_getFile
 */

private[_curFiles, _filePath];

_curFiles = _this select 0;
_filePath = _this select 1;


if(count _filePath > 1)then{								//If the file path is more than MASTER
	{														//For each file in filePath
		_curFiles = [_curFiles, _x] call File_fnc_getFile;		//get that file and set it to the current file to search through
	}forEach (_filePath select [1, count _filepath - 1]);	//^For each file in filePath
};
_curFiles;