/**
	Creates a new command line object with necessary variables
*/
_prevLines = [];										//Array of all lines before current line
_filePath = ["MASTER"];									//Path to Current Directory including current Directory
_curLine = [[_filePath] call Line_fnc_parseFilePath] call Line_fnc_newLine;		//Current Line
_prevCommands = [];										//All commands previously put into the command line
_prevCommandIndex = 0;									//Index of which previous command the user is at
_yOffset = 0;											//Int val of how far to offset y cord of text for scrolling
_cache = [false];										//Array for passing data to subsequent lines in a multi line operation
														//Index 0 of cache is weather or not to look at it
_safeMode = false;										//Weather or not to star out text input (*****)

_temp = "Welcome to Arma Terminal! (version >0.1)<br/>"+
		"Use 'page up' and 'page down' to scroll. "+
		"If you don't know any commands, type 'HELP' to display a list of all* available commands. "+
		"<br/><br/>" +
		"* help screen not always kept up to date :)"+
		"<br/>";
_prevLines = [_prevLines, [_temp]] call Line_fnc_push;	//Pushes generic help to top of screen for first time users
[
	_prevLines,
	_curLine,
	_filePath,
	_prevCommands,
	_prevCommandIndex,
	_yOffset,
	_cache,
	_safeMode
];