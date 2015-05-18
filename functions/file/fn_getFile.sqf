/*
 *	Joshua Shear
 *	File_fnc_getFile.sqf
 * 	Takes in a parent folder and a folder name and returns the folder who's name is specified
 */
private[_parent,_fName,_contents,_file];

_parent = _this select 0;
_fName = [_this select 1] call CommandLine_fnc_alphaToAlpha;
_contents = _parent select 1;

_file = 0;
{
	if(str(_x select 0) == str(_fName))then{		//If the specified file name matches any file in the current directory
		_file = _x;
	};
}forEach _contents;

_file;