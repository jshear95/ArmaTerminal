/*
 *	Joshua Shear
 *	Steed_fnc_steed.sqf
 *	Takes in a file name and char array
 *	Returns a textEditor (STEED)
 */

private[_fileName, _fileContents, _permission,_header,_prevText,_postText,_yOffset,_steed];

_fileName = _this select 0;
_fileContents = _this select 1;
_permission = _this select 2;

_header = _fileName + "<br/>Control+Z to exit without saving<br/>Control+S to save and exit<br/>";
_prevText = [""];
_postText = _fileContents;
_yOffset = 0;

_steed = [_fileName, _header, _prevText, _postText, _yOffset, _permission];

_steed;
