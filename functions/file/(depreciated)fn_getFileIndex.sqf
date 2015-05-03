/*
 * Takes in a parent folder and a folder name and returns the specified folder's index
 */
private[_parent,_fileName];
_parent = _this select 0;
_fileName = [_this select 1] call CommandLine_fnc_alphaToAlpha;
_contents = [_parent] call File_fnc_getContents;

_index = -1;
_loop = true;

while{_index < count _contents && _loop}do{
	_index = _index + 1;
	if(str([_contents select _index] call File_fnc_getName) == str(_fileName))then{
		_loop = false;
	};
};

if(_loop)then{
	_index = -1;
};

_index;

















/*
_file = 0;
{
	if(str([_contents select _index] call File_fnc_getName) == str(_fileName))then{
		_file = _x;
	};
}forEach _contents;

_file;
*/