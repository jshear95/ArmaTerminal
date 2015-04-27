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
			"  HELP    Displays all supported commands.<br/>"+
			"  QUIT    Exits the terminal.";
	};
};

[_output,_computer];