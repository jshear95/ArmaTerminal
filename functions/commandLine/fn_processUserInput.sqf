/*
 *	Joshua Shear
 *	CommandLine_fnc_processUserInput.sqf
 *	Takes in input and a computer and then processes user input by appending chars, executing lines, removing chars, scrolling, or fetching and displaying previous commands
*/

private[_computer,_return,_backSpace,_up,_down,_userInput,_scrollUp,_scrollDown,_control,_users,_files,_currentUser,_computerName,_state,_commandLine,_color,_steed,_dev,_prevLines,_curLine,_filePath,_prevCommands,_prevCommandIndex,_yOffset,_cache,_safe,_lineHeight];

_computer = _this select 0;

_return = _this select 0 select 0;
_backSpace = _this select 0 select 1;
_up = _this select 0 select 2;
_down = _this select 0 select 3;
_userInput = _this select 0 select 4;
_scrollUp = _this select 0 select 5;
_scrollDown = _this select 0 select 6;
_control = _this select 0 select 7;

_users = _this select 1 select 0;
_files = _this select 1 select 1;
_currentUser = _this select 1 select 2;
_computerName = _this select 1 select 3;
_state = _this select 1 select 4;
_commandLine = _this select 1 select 5;
_color = _this select 1 select 6;
_steed = _this select 1 select 7;
_dev = _this select 1 select 8;

_prevLines = _commandLine select 0;
_curLine = _commandLine select 1;
_filePath = _commandLine select 2;
_prevCommands = _commandLine select 3;
_prevCommandIndex = _commandLine select 4;
_yOffset = _commandLine select 5;
_cache = _commandLine select 6;
_safe = _commandLine select 7;

_lineHeight = 0.05527;	//This is the height of a line of text. This was measured on a 2880x1800 monitor (long story) but it should work for any sized monitor.
						//NO LONGER ACCURATE, GOOD APPROXIMATE FOR TIME BEING

switch true do {
	case (_return) : {
		//push curLine to prevLines
		_cache = _commandLine select 6;
		_temp = _curLine - [_curLine select 0];
		if(!(_cache select 0))then{				//If cache is not in use, push curLine to prevCommands
			_prevCommands = [_prevCommands, [_temp]] call Line_fnc_push;
			_prevCommandIndex = count _prevCommands;
		}else{									//If cache is in use, log curLine for processing
			_cache set [count _cache, _temp];
		};
		
		//execute current line
		_cmd = [_curLine] call CommandLine_fnc_getCommand;
		_exe = [_cmd,_this select 1] call CommandLine_fnc_executeLine;
		
		_users = _exe select 1 select 0;
		_files = _exe select 1 select 1;
		_currentUser = _exe select 1 select 2;
		_computerName = _exe select 1 select 3;
		_state = _exe select 1 select 4;
		_commandLine = _exe select 1 select 5;
		_color = _exe select 1 select 6;
		_steed = _exe select 1 select 7;
		
		if(_safe)then{	//Star out input from current line
			for[{_i = 1},{_i < count _curLine},{_i = _i + 1}]do{
				_curLine set [_i, "*"];
			};
		};
		
		//create new line
		_prevLines = [_prevLines,_curLine] call Line_fnc_push;
		_output = _exe select 0;
		if(_output != "")then{											//If output is empty string then don't add to prevLines
			_prevLines = [_prevLines,[_output]] call Line_fnc_push;
		};
		
		_cache = _commandLine select 6;
		if(!(_cache select 0))then{										//If cache is not in use, then create a normal next line
			_filePath = _commandLine select 2;
			_curLine = [[_filePath] call Line_fnc_parseFilePath] call Line_fnc_newLine;
		}else{															//If cache is in use, create a next line with prompt specified in cache
			_curLine = [_cache select 2] call Line_fnc_newLine;
		};
		
		//Update all changed variables in commandLine
		_commandLine set [0,_prevLines];
		_commandLine set [1,_curLine];
		_commandLine set [2,_filePath];
		_commandLine set [3,_prevCommands];
		_commandLine set [4,_prevCommandIndex];
		_commandLine set [6,_cache];
	};
	case (_backSpace) : {
		//Pop char from curLine
		if(count _curLine > 1) then {				//If there are input chars on the current line
			_pop = [_curLine] call Line_fnc_pop;	//Remove the last char from current line
		};
		_curLine = _curLine - [""];					//Update current line reference
		
		//Update all changed variables in commandLine
		_commandLine set [1,_curLine];
	};
	case (_up) : {
		//display next prevCommand
		if(_prevCommandIndex > 0)then{								//If there is a previous command
			_prevCommandIndex = _prevCommandIndex - 1;				//Set Index
			_temp = _prevCommands select _prevCommandIndex;			//Get command at index
			_curLine = [_curLine select 0];							//Get directory or whatnot that precedes user text
			_temp = _temp select 0;									//Unpack the command
			
			{														//Extract the command
				_curLine = [_curLine, _x] call Line_fnc_push;
			}forEach _temp;
		};
		
		//Update all changed variables in commandLine
		_commandLine set [1,_curLine];
		_commandLine set [4,_prevCommandIndex];
	};
	case (_down) : {
		//display previous prevCommand
		
		if(_prevCommandIndex < count _prevCommands - 1)then{	//If we are not at the most recent command
			_prevCommandIndex = _prevCommandIndex + 1;			//Set index
			_temp = _prevCommands select _prevCommandIndex;		//Get command at index
			_curLine = [_curLine select 0];						//Get directory or whatnot that precedes user text
			_temp = _temp select 0;								//unpack the command
			
			{													//Extract the command
				_curLine = [_curLine, _x] call Line_fnc_push;
			}forEach _temp;
		};
		
		//Update all changed variables in commandLine
		_commandLine set [1,_curLine];
		_commandLine set [4,_prevCommandIndex];
	};
	case (_scrollUp) : {
		//Scrolls page up
		_yOffset = _yOffset + _lineHeight;
		
		//Update all changed variables in commandLine
		_commandLine set [5,_yOffset];
	};
	case (_scrollDown) : {
		//Scrolls page down
		_yOffset = _yOffset - _lineHeight;
		
		//Update all changed variables in commandLine
		_commandLine set [5,_yOffset];
	};
	case (_control && _userInput == "x") : {
		//Clear all previous lines and resets offset so curLine is visible
		_prevLines = [];
		_yOffset = 0;
		
		//Update all changed variables in commandLine
		_commandLine set [0, _prevLines];
		_commandLine set [5,_yOffset];
	};
	case (!(_userInput == "")) : {
		//Key has been pressed
		_curLine = _curLine - [""];								//Always clear empty strings from curLine
		
		//push key to curLine
		_curLine = [_curLine,_userInput] call Line_fnc_push;
		
		//Update all changed variables in commandLine
		_commandLine set [1,_curLine];
	};
};

//Updates computer
_computer set[0, _users];
_computer set[1, _files];
_computer set[2, _currentUser];
_computer set[3, _computerName];
_computer set[4, _state];
_computer set[5, _commandLine];
_computer set[6, _color];
_computer set[7, _steed];
_computer set[8, _dev];

//Returns computer
_computer;