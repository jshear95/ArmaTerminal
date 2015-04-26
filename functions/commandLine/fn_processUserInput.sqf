/**
	processes user input and appends char, executes line, removes char, scrolls, or fetch and displays previous commands
*/

private[_return,_backSpace,_up,_down,_userInput,_users,_files,_currentUser,_computerName,_state,_commandLine];

_return = _this select 0 select 0;
_backSpace = _this select 0 select 1;
_up = _this select 0 select 2;
_down = _this select 0 select 3;
_userInput = _this select 0 select 4;
_users = _this select 1 select 0;
_files = _this select 1 select 1;
_currentUser = _this select 1 select 2;
_computerName = _this select 1 select 3;
_state = _this select 1 select 4;
_commandLine = _this select 1 select 5;
_prevLines = _commandLine select 0;
_curLine = _commandLine select 1;
_return = [];
switch true do {
	case (_return) : {
		//Enter has been pressed
		/*
			reset command history
			execute current line
			push curLine to prevLines
			create new line
		 */
		 //_prevLines = [_prevLines] call CommandLine_fnc_push;
		 //_curLine = ["MASTER: "] call Line_fnc_newLine;
		 _return;
	};
	case (_backSpace) : {
		//BackSpace has been pressed
		//Pop char from curLine
		_pop = [_curLine] call Line_fnc_pop;
		_curLine = _curLine - [""];
	};
	case (_up) : {
		//pop and display prevCommand
		_return;
	};
	case (_down) : {
		//pop and display prevScrolledCommand
		_return;
	};
	case (!(_userInput == "")) : {
		//Key has been pressed
		//push key to curLine
		
		_curLine = _curLine - [""];
		_curLine = [_curLine,_userInput] call Line_fnc_push;
	};
};


_commandLine = [_prevLines, _curLine, _commandLine select 2, _commandLine select 3, _commandLine select 4];

[_users,_files,_currentUser,_computerName,_state,_commandLine];