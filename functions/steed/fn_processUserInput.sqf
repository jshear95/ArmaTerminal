/*
 *	Joshua Shear
 *	Steed_fnc_processUserInput.sqf
 *	processes user input and appends char, executes line, removes char, scrolls, or fetch and displays previous commands
 *	
 *	How to call : [input,computer] call Steed_fnc_processUserInput.sqf
 *	
 *	Returns: a computer
 *	
 *	Function calls :
 *		CommandLine_fnc_getCurrentDir
 *		File_fnc_getFile
 */

private _return = _this select 0 select 0;
private _backSpace = _this select 0 select 1;
private _up = _this select 0 select 2;
private _down = _this select 0 select 3;
private _userInput = _this select 0 select 4;
private _scrollUp = _this select 0 select 5;
private _scrollDown = _this select 0 select 6;
private _control = _this select 0 select 7;
private _left = _this select 0 select 8;
private _right = _this select 0 select 9;
private _delete = _this select 0 select 11;
private _home = _this select 0 select 12;
private _end = _this select 0 select 13;
private _copy = (_control && str(_userInput) == str("C"));
private _paste = (_control && str(_userInput) == str("V"));
private _save = (_control && str(_userInput) == str("S"));
private _exit = (_control && str(_userInput) == str("Z"));

private _computer = _this select 1;

private _users = _this select 1 select 0;
private _files = _this select 1 select 1;
private _currentUser = _this select 1 select 2;
private _computerName = _this select 1 select 3;
private _state = _this select 1 select 4;
private _commandLine = _this select 1 select 5;
private _color = _this select 1 select 6;
private _steed = _this select 1 select 7;
private _dev = _this select 1 select  8;

private _zfileName = _steed select 0;
private _header = _steed select 1;
private _preText = _steed select 2;
private _postText = _steed select 3;
private _yOffset = _steed select 4;
private _owner = _steed select 5;
private _curDir = _steed select 6;

private _lineHeight = 0.00281 * 11;	//This is the height of a line of text. Format = scale * pix height on 1920x1080 monitor. Might be off after several hundred lines, cannot test that far out.

switch true do {
	case (_return) : {
		//Add <br/>
		_preText set[count _preText, "<br/>"];
		_steed set[2, _preText];
	};
	case (_backSpace) : {
		//Remove char from preText
		if(count(_preText) > 1)then{								//If there should be a char in preText
			_preText = (_preText select[0, count _preText - 1]);	//Remove the desired char
		}else{														//If preText should be empty, make it so
			_preText = [""];
		};
		
		_steed set[2, _preText];
	};
	case (_delete) : {
		//Remove char from postText
		if(count(_postText) > 1)then{								//If there should be a char in postText
			_postText = (_postText select[1, count _postText - 1]);	//Remove the shifted char
		}else{														//If postText should be empty, make it so
			_postText = [""];
		};
		
		_steed set[3,_postText];
	};
	case (_left) : {
		//move cursor left
		if(str(_preText) != str([""]))then{								//If there is something to the left
			private _char = _preText select (count _preText - 1);				//Get the char to the left
			
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
			private _char = _postText select 0;									//Get the char to the right
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
	case (_home) : {
		_postText = _preText + _postText;
		_preText = [""];
		
		private _char = _postText select 0;									//Get the char to the right
		_preText set [count _preText, _char];						//Append the char to the end of preText
		_postText = (_postText select[1, count _postText - 1]);	//Remove the shifted char
		
		_steed set[2, _preText];
		_steed set[3,_postText];
	};
	case (_end) : {
		_preText = _preText + _postText;
		_postText = [""];
		
		_steed set[2, _preText];
		_steed set[3,_postText];
	};
	case (_scrollUp) : {
		//Scrolls page up
		_yOffset = (_yOffset + _lineHeight);
		_steed set [4,_yOffset];
	};
	case (_scrollDown) : {
		//Scrolls page down
		_yOffset = (_yOffset - _lineHeight);
		_steed set [4,_yOffset];
	};
	case (_save) : {
		//control and s have been pressed, init saving if the user has permission
		hint "Attempting save";
		if((str([_curDir,_zfileName] call File_fnc_getFile) != str(0) and [[_curDir,_zfileName] call File_fnc_getFile,_currentUser] call File_fnc_hasWritePermission) or (str([_curDir,_zfileName] call File_fnc_getFile) == str(0) and [_curDir,_currentUser] call File_fnc_hasWritePermission))then{
			_filePath = _commandLine select 2;
			
			_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			_theFile = [_curDir,_zfileName] call File_fnc_getFile;
			
			_contents = [];													//What will be the file contents
			{_contents set[count _contents, _x];}forEach _preText;			//Add the text before the cursor to the file contents
			{_contents set[count _contents, _x];}forEach _postText;			//Add the text after the cursor to the file contents
			_contents = _contents - [""];									//Remove all empty strings from the contents
			
			if(str(_theFile) != str(0))then{
				_theFile set[1, _contents];									//Set contents
			}else{
				//File does not exist
				_theFile = [_zfileName, _contents, _owner,[7,4,0]];
				if(_currentUser == "PUBLIC")then{_theFile set [3,[7,7,7]]};
				(_curDir select 1) set[count (_curDir select 1), _theFile];	//Add the file to the directory
			};
			hint "FILE SAVED";
		}else{hint "SAVE FAILED";};
	};
	case (_copy) : {
		//Copies all text in the document into the window's clipboard
		private _stuff = _preText + _postText;
		private _txt = [_stuff] call Line_fnc_inputToString;
		copyToClipboard _txt;
	};
	case (_paste) : {
		private _txt = copyFromClipboard;
		
		private _brs = [];									//Indexes of all <br/>'s
		private _tmp = toUpper _txt;
		private _ind = _tmp find "<BR/>";
		
		while{_ind != -1}do{						//While there is another <br/>
			_brs set[count _brs, _ind];
			_tmp = [_tmp, _ind + 1] call BIS_fnc_trimString;
			_ind = (_tmp find "<BR/>");
		};
		
		private _stuff = [];
		for [{private _i = 0}, {_i < count _txt}, {_i = _i + 1}] do {	//For each char in txt
			_stuff set [_i, _txt select [_i,1]];
		};
		private _val = 0;
		{
			_val = _val + _x;				//Offset the index in _brs to account for the algorithm above which substringed
			_stuff set [_val, "<br/>"];		//Set zeroth char to line break char
			_stuff set [_val + 1, ""];		//Set remaining to empty string
			_stuff set [_val + 2, ""];
			_stuff set [_val + 3, ""];
			_stuff set [_val + 4, ""];
			_val = _val + 1;
		}forEach _brs;
		_stuff = _stuff - [""];				//Remove all empty strings

		_preText = [""];
		_postText = _stuff;
		
		_steed set[2, _preText];
		_steed set[3,_postText];
		
	};
	case (_exit) : {
		//control and z have been pressed, init exit
		_state = "COMMANDLINE";
	};
	case (!(_userInput == "")) : {
		//Append key to preText
		_preText set[count _preText, _userInput];
		_steed set[2, _preText];
	};
};

_computer set[0, _users];
_computer set[1, _files];
_computer set[2, _currentUser];
_computer set[3, _computerName];
_computer set[4, _state];
_computer set[5, _commandLine];
_computer set[6, _color];
_computer set[7, _steed];
_computer set[8, _dev];

_computer;