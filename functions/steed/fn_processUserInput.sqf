/**
	processes user input and appends char, executes line, removes char, scrolls, or fetch and displays previous commands
*/
private[_return,_backSpace,_up,_down,_userInput,_scrollUp,_scrollDown,_users,_files,_currentUser,_computerName,_state,_commandLine,_color,_steed];

_return = _this select 0 select 0;
_backSpace = _this select 0 select 1;
_up = _this select 0 select 2;
_down = _this select 0 select 3;
_userInput = _this select 0 select 4;
_scrollUp = _this select 0 select 5;
_scrollDown = _this select 0 select 6;
_control = _this select 0 select 7;
_left = _this select 0 select 8;
_right = _this select 0 select 9;
_insert = false;
_delete = false;
_home = false;
_end = false;
_save = false;
_exit = (_control && str(_userInput) == str("Z"));

_users = _this select 1 select 0;
_files = _this select 1 select 1;
_currentUser = _this select 1 select 2;
_computerName = _this select 1 select 3;
_state = _this select 1 select 4;
_commandLine = _this select 1 select 5;
_color = _this select 1 select 6;
_steed = _this select 1 select 7;

_fileName = _steed select 0;
_preText = _steed select 2;
_postText = _steed select 3;
_yOffset = _steed select 4;

_lineHeight = 0.05527;	//This is the height of a line of text. This was measured on a 2880x1800 monitor (long story) but it should work for any sized monitor.
						//NO LONGER ACCURATE, GOOD APPROXIMATE FOR TIME BEING

switch true do {
	case (_return) : {
		//Add <br/>

	};
	case (_backSpace) : {
		//Remove char from preText

	};
	case (_delete) : {
		//Remove char from postText
	};
	case (_left) : {
		//move cursor left
		if(str(_preText) != str([""]))then{								//If there is something to the left
			_char = _preText select (count _preText - 1);				//Get the char to the left
			reverse _postText;											//Flip the post text for easier access
			_postText set[count _postText, _char];						//Append the char to post text at the 'front'
			reverse _postText;											//Flip the post text back to normal
			if(count(_preText) > 1)then{								//If there should be a char in preText
				_preText = (_preText select[0, count _preText - 1]);	//Remove the shifted char
			}else{														//If preText should be empty, make it so
				_preText = [""];
			};
		};
		_steed set[2, _preText];
		_steed set[3,_postText];
	};
	case (_right) : {
		//move cursor right
		if(str(_postText) != str([""]))then{							//If there is something to the right
			_char = _postText select 0;									//Get the char to the right
			_preText set [count _preText, _char];						//Append the char to the end of preText
			if(count(_postText) > 1)then{								//If there should be a char in postText
				_postText = (_postText select[1, count _postText - 1]);	//Remove the shifted char
			}else{														//If postText should be empty, make it so
				_postText = [""];
			};
		};
		_steed set[2, _preText];
		_steed set[3,_postText];
	};
	case (_scrollUp) : {
		//Scrolls page up
		_yOffset = _yOffset + _lineHeight;
		_steed set [4,_yOffset];
	};
	case (_scrollDown) : {
		//Scrolls page down
		_yOffset = _yOffset - _lineHeight;
		_steed set [4,_yOffset];
	};
	case (_save) : {
		//control and s have been pressed, init saving
	};
	case (_exit) : {
		//control and z have been pressed, init exit
		_state = "COMMANDLINE";
	};
	case (!(_userInput == "")) : {
		//Append key to preText

	};
};

[_users,_files,_currentUser,_computerName,_state,_commandLine,_color,_steed];