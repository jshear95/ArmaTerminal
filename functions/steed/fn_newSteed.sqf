/*
 *	Joshua Shear
 *	Steed_fnc_steed.sqf
 *	Takes in the file to edit, the current user, and weather or not this is a new file or it will be creating a file
 *	Returns a textEditor (STEED)
 *	
 *	How to call : [file,current User,real file] call Steed_fnc_newSteed;
 *	
 *	Returns: new steed
 *	
 *	Function calls :
 *		NONE
 *		
 */
#define KEYLOGUP(DISPLAY) (findDisplay DISPLAY) displayAddEventHandler["KeyUp", { player setVariable ["pressedKey", (_this select 1)]; player setVariable ["shift", (_this select 2)]; player setVariable ["control", (_this select 3)];}]
#define KEYLOGDOWN(DISPLAY) (findDisplay DISPLAY) displayAddEventHandler["KeyDown", {true}]


private _fileName = _this select 0 select 0;
private _fileContents = _this select 0 select 1;
private _owner = _this select 0 select 2;
private _permissions = _this select 0 select 3;
private _user = _this select 1;
private _curDir =_this select 2;
private _realFile = _this select 2;

private _header = _fileName + "\nControl+Z to exit (will not save, to keep progress, manually save first)\nControl+S to save\n";

private _prevText = [""];
private _postText = _fileContents;
private _yOffset = 0;

private _lineCount = 3;											//How many lines are visible in the terminal

createDialog "Editor";
_KeyUp2 = KEYLOGUP(2);
_KeyDown2 = KEYLOGDOWN(2);

private _steed = [_fileName, _header, _prevText, _postText, _yOffset, _owner,_curDir,_lineCount];

_steed;
