/*
 * Takes in a file system and a current file path.
 * Walks through the file path until it reaches the current open directory
 * Returns the current open directory
 */

private[_files, _filePath];
_files = _this select 0;
_filePath = _this select 1;
_progress = true;
//Master/dirA
//Master[dirA,dirB,dirC,DocD];


if(count _filePath > 1)then{
	{
		_files = [_files, _x] call File_fnc_getFile;
	}forEach (_filePath select [1, count _filepath - 1]);
};
_files;




/*
/*p = t
curFile = folderA
f = f
* /
if(count _filePath > 1)then{
	{
		if(_progress)then{
			_curFile = [_x] call CommandLine_fnc_alphaToAlpha;
			_found = false;
			{
				hint str([_x] call File_fnc_getName);
				if(_curFile == ([_x] call File_fnc_getName) && !_found)then{
					hint "TEST1";
					_files = _x;
					_found = true;
				};
				_progress = !_found;
			}forEach ([_files] call File_fnc_getContents);
		};
	} forEach (_filePath select [1, count _filePath - 1]);
};
_files;*/