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
_prevCommands = _commandLine select 3;
_prevCommandIndex = _commandLine select 4;

switch true do {
	case (_return) : {
		//Enter has been pressed
		/*
			reset command history
			execute current line
			push curLine to prevLines
			create new line
		 */
		 _temp = _curLine - [_curLine select 0];
		 _prevCommands = [_prevCommands, [_temp]] call Line_fnc_push;
		 _prevCommandIndex = count _prevCommands;
		 _prevLines = [_prevLines,_curLine] call Line_fnc_push;
		 _curLine = ["MASTER: "] call Line_fnc_newLine;
	};
	case (_backSpace) : {
		//BackSpace has been pressed
		//Pop char from curLine
		if(count _curLine > 1) then {
			_pop = [_curLine] call Line_fnc_pop;
		};
		_curLine = _curLine - [""];
	};
	case (_up) : {
		//display next prevCommand
		if(_prevCommandIndex > 0)then{
			_prevCommandIndex = _prevCommandIndex - 1;
			_temp = _prevCommands select _prevCommandIndex;
			_curLine = [_curLine select 0];
			_temp = _temp select 0;
			{
				_curLine = [_curLine, _x] call Line_fnc_push;
			}forEach _temp;
			
		};
		_curLine;
	};
	case (_down) : {
		//display previous prevCommand
		if(_prevCommandIndex < count _prevCommands - 1)then{
			_prevCommandIndex = _prevCommandIndex + 1;
			_temp = _prevCommands select _prevCommandIndex;
			_curLine = [_curLine select 0];
			_temp = _temp select 0;
			{
				_curLine = [_curLine, _x] call Line_fnc_push;
			}forEach _temp;
		};
		_curLine;
	};
	case (!(_userInput == "")) : {
		//Key has been pressed
		//push key to curLine
		_curLine = _curLine - [""];
		_curLine = [_curLine,_userInput] call Line_fnc_push;
		
	};
};

_commandLine = [_prevLines, _curLine, _commandLine select 2, _prevCommands, _prevCommandIndex];

[_users,_files,_currentUser,_computerName,_state,_commandLine];