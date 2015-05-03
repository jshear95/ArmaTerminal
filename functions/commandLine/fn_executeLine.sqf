/*
 * Takes a command value and any parameters and executes the command with given perimeters.
 * It also takes in the computer to allow for operations on the computers state
 * It returns the output line of the command, and the updated computer
 */

private [_arg,_computer];

_arg = _this select 0;
_cmd = _arg select 0;
_computer = _this select 1;

_output = "The command you entered is not recognised as a command. Type 'HELP' in order to see a list of supported commands.";

switch true do {
	case(str(_cmd) == str("QUIT")):{
	
		_computer set[4,"QUIT"];
		
		_output = "";
	};
	case(str(_cmd) == str("HELP")):{
		_output = "Supported Commands:<br/>"+
			"  HELP           Displays all supported commands<br/>"+
			"  TIME           Displays the current date and time   m/d/y hr:min<br/>"+
			"  WHOAMI        Displays the current active user's user name <br/>"+
			"  COLOR         Toggles color of text between green and white<br/>"+
			"  LS             Displays all files in current active directory<br/>" +
			"  CD [DirName]   Opens the specified directory, no [] braces, 'cd ..' returns you to the parent directory<br/>" +
			"  RN [DirName] [NewName]   Renames the directory matching the first parameter with the name specified in the second parameter, no [] braces<br/>" +
			"  QUIT           Exits the terminal<br/>"+
			"When specifying arguments, the '\' key is the escape character. You can press this to allow for spaces in your arguments by typing '\ '";
	};
	case(str(_cmd) == str("TIME")):{
		_date = date;				// [year, month, day, hour, minute]
		_year = _date select 0;
		_month = _date select 1;
		_day = _date select 2;
		_hour = _date select 3;
		_minute = _date select 4;
		
		if(_minute < 10)then{ _minute = "0"+str(_minute);};				//Format time right
		
		_output = format ["%1/%2/%3  %4:%5",_month,_day,_year,_hour,_minute];
	};
	case(str(_cmd) == str("WHOAMI")):{
		_output = "No user currently logged in.";
		
		if(_computer select 2 != "PUBLIC")then{
			_output = _computer select 2;
		};
		
		_output;
	};
	case(str(_cmd) == str("COLOR")):{
		_color = _computer select 6;
		
		if(_color == "#33CC33")then{
			_color = "#FFFFFF";
			_output = "Color changed to white";
		}else{
			_color = "#33CC33";
			_output = "Color changed to green";
		};
		
		_computer set [6, _color];
		
		_output;
	};
	case(str(_cmd) == str("LS")):{
		_commandLine = _computer select 5;
		_filePath = _commandLine select 2;
		_files = _computer select 1;
		
		_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
		_output = "";
		_inc = 0;
		
		{
			_inc = _inc + 1;				//To account for last line not needing a br
			_fileName = str(_x select 0);	//Converts from errorString to string with extra ""
			_fileName = _fileName select [1,(count _fileName - 2)];	//Removes extra ""
																	//Apparently you can substring in Arma, who new
			
			if(_inc != count(_curDir select 1))then{
				_output = _output + _fileName + "<br/>";
			}else{
				_output = _output + _fileName;
			};
		}forEach ([_curDir] call File_fnc_getContents);
		
		_output;
	};
	case(str(_cmd) == str("CD")):{
	
		_commandLine = _computer select 5;
		_filePath = _commandLine select 2;
		_files = _computer select 1;
		
		_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
		_fileName = [_arg select 1] call Line_fnc_inputToString;
		_params = [_fileName] call Line_fnc_parseSpaceDeliniation;
		_fileName = _params select 0;
		
		if(_fileName == ".." || _fileName == "../")then{
			if(count _filePath > 1)then{
				_filePath set [count _filePath - 1, ""];
				_filePath = _filePath - [""];
				_output = "";
			}else{
				_output = "Already in root directory";
			};
		}else{
			_file = [_curDir,_fileName] call File_fnc_getFile;
			if(str(_file) != str(0))then{
				if(typeName(_file select 1) == "ARRAY")then{
					_filePath = _filePath + [_file select 0];
					_output = "";
				}else{
					_output = str(_fileName) + " : Not a directory";
				};
			}else{
				_output = str(_fileName) + " : No such file or directory";
			};
		};
		
		_commandLine set[2, _filePath];
		_computer set[5, _commandLine];
		
		_output;
	};
	case(str(_cmd) == str("RN")):{
		
		_output = "";
		
		_commandLine = _computer select 5;
		_filePath = _commandLine select 2;
		_files = _computer select 1;
		
		_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
		
		_remainingLine = [_arg select 1] call Line_fnc_inputToString;
		
		_params = [_remainingLine] call Line_fnc_parseSpaceDeliniation;
		
		_prevName = _params select 0;
		_newName = _params select 1;
		
		switch(true)do{
			case(str([_curDir,_prevName] call File_fnc_getFile) == str(0)):{
				_output = "Unspecified File Name";
			};
			case(count _params < 2):{
				_output = "No new name specified for file";
			};
			case(str([_curDir,_newName] call File_fnc_getFile) != str(0)):{
				_output = "New file name already exists in current directory";
			};
			case(str([_curDir,_prevName] call File_fnc_getFile) != str(0)):{
				_theFile = [_curDir,_prevName] call File_fnc_getFile;
				_theFile set[0, _newName];
				_output = "File name changed from ''" + _prevName + "'' to ''" + _newName + "''.";
			};
		};
		
		_output;
	};
};

[_output,_computer];