/*
 *	Joshua Shear
 *	File_fnc_getFileIndex.sqf
 *	Takes in a parent folder and a folder name and returns the specified folder's index
 */
private[_parent,_fileName,_contents,_index,_loop];

_parent = _this select 0;
_fileName = [_this select 1] call CommandLine_fnc_alphaToAlpha;
_contents = _parent select 1;

_index = -1;
_loop = true;

while{_index < count _contents && _loop}do{						//while there are unchecked files in the current directory and the file has not been found
	_index = _index + 1;
	if(str(_contents select _index select 0) == str(_fileName))then{		//If the specified name matches the name of the file being checked
		_loop = false;
	};
};

if(_loop)then{
	_index = -1;
};

_index;