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
	case(_cmd == "QUIT"):{
		_computer set[4,"QUIT"];
		_output = "";
	};
	case(_cmd == "HELP"):{
		_output = "Supported Commands:<br/>"+
			"  HELP    Displays all supported commands<br/>"+
			"  TIME    Displays the current date and time   m/d/y hr:min<br/>"+
			"  WHOAMI  Displays the current active user's user name <br/>"+
			"  COLOR   Toggles color of text between green and white<br/>"+
			"  LS      Displays all files in current active directory<br/>" +
			"  QUIT    Exits the terminal";
	};
	case(_cmd == "TIME"):{
		_date = date;				// [year, month, day, hour, minute]
		_year = _date select 0;
		_month = _date select 1;
		_day = _date select 2;
		_hour = _date select 3;
		_minute = _date select 4;
		if(_minute < 10)then{ _minute = "0"+str(_minute);};				//Format time right
		_output = format ["%1/%2/%3  %4:%5",_month,_day,_year,_hour,_minute];
	};
	case(_cmd == "WHOAMI"):{
		_output = "No user currently logged in.";
		if(_computer select 2 != "PUBLIC")then{
			_output = _computer select 2;
		};
		_output;
	};
	case(_cmd == "COLOR"):{
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
	case(_cmd == "LS"):{
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
};

[_output,_computer];