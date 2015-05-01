/*
 * Takes in a parent folder and a folder name and returns the folder who's name is specified
 */
private[_parent,_fileName];
_parent = _this select 0;
_fileName = [_this select 1] call CommandLine_fnc_alphaToAlpha;
_contents = [_parent] call File_fnc_getContents;

_file = 0;
{
	if(str([_x] call File_fnc_getName) == str(_fileName))then{
		_file = _x;
	};
}forEach _contents;

_file;