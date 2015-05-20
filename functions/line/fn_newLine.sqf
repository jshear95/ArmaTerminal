/*
 *	Joshua Shear
 *	Line_fnc_newLine.sqf
 *	Takes in preText and creates a line with preText (current directory / hanging command output) and user text
 *	
 *	How to call : [pre text (char array)] call Line_fnc_newLine;
 *	
 *	Returns : a new line
 *	
 *	Function calls :
 *		NONE
*/
private [_preText,_userText];

_preText = _this select 0;
_userText = "";

[
	_preText,
	_userText
];
