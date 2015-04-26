/**
	Creates a new command line object with necessary variables
*/
_prevLines = [];										//Array of all lines before current line
_curLine = ["MASTER: "] call Line_fnc_newLine;			//Current Line
_curDir = "MASTER";										//Current Directory
_prevCommands = [];										//All commands previously put into the command line
_scrolledCommands = [];									//All commands sorted so far
[
	_prevLines,
	_curLine,
	_curDir,
	_prevCommands,
	_scrolledCommands
];