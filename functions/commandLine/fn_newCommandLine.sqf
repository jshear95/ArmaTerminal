/**
	Creates a new command line object with necessary variables
*/
_prevLines = [];										//Array of all lines before current line
_curLine = ["MASTER: "] call Line_fnc_newLine;			//Current Line
_curDir = "MASTER";										//Current Directory
_prevCommands = [];										//All commands previously put into the command line
_prevCommandIndex = 0;									//Index of which previous command the user is at
[
	_prevLines,
	_curLine,
	_curDir,
	_prevCommands,
	_prevCommandIndex
];