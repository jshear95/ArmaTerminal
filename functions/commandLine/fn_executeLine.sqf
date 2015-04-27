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
};

[_output,_computer];