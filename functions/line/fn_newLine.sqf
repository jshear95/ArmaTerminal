/*
 *	Joshua Shear
 *	Line_fnc_newLine.sqf
 *	Takes in preText and creates a line with preText (current directory / hanging command output) and user text
*/
private [_preText,_userText];

_preText = _this select 0;
_userText = "";

[
	_preText,
	_userText
];
