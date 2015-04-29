/*
 * Takes in a file system and a current file path.
 * Walks through the file path until it reaches the current open directory
 * Returns the current open directory
 */

private[_files, _filePath];
_files = _this select 0;
_filePath = _this select 1;
_progress = true;
{
	if(_progress)then{
		_curFile = _x;
		_found = false;
		{
			if(_curFile == ([_x] call File_fnc_getName) && !_found)then{
				_files = _x;
				_found = true;
			};
			_progress = _found;
		}forEach ([_files] call File_fnc_getContents);
	};
} forEach _filePath;

_files;