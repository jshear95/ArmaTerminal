/*
 *	Joshua Shear
 *	CommandLine_fnc_newCommandLine.sqf
 *	Creates a new command line object with necessary variables
 *	
 *	How to call : [] CommandLine_fnc_newCommandLine;
 *	
 *	Returns : A new command line
 *	
 *	Function calls :
 *		Line_fnc_parseFilePath
 *		Line_fnc_newLine
 *		Line_fnc_push
*/

private _prevLines = [];										//Array of all lines before current line
private _filePath = ["MASTER"];									//Path to Current Directory including current Directory
private _curLine = [[_filePath] call Line_fnc_parseFilePath] call Line_fnc_newLine;		//Current Line
private _prevCommands = [];										//All commands previously put into the command line
private _prevCommandIndex = 0;									//Index of which previous command the user is at
private _yOffset = 0;											//Int val of how far to offset y cord of text for scrolling
private _cache = [false];										//Array for passing data to subsequent lines in a multi line operation
																//Index 0 of cache is weather or not to look at it
private _safeMode = false;										//Weather or not to star out text input (*****)
private _lineCount = 3;											//How many lines are visible in the terminal

private _temp = "Welcome to Arma Terminal! (version 0.1.1)\n"+
		"Use 'page up' and 'page down' to scroll. "+
		"If you don't know any commands, type 'HELP' to display a list of all available commands. "+
		"\n";
_prevLines = [_prevLines, [_temp]] call Line_fnc_push;	//Pushes generic help to top of screen for first time users

createDialog "Terminal";


[
	_prevLines,
	_curLine,
	_filePath,
	_prevCommands,
	_prevCommandIndex,
	_yOffset,
	_cache,
	_safeMode,
	_lineCount
];