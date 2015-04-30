/*
 * Takes in user input and evaluates it to get the command and any parameters.
 * If input matches no command, it returns an error.
 */

private [_userInput];
_userInput = _this select 0;
_output = ["ERROR"];

_userInput = _userInput - [_userInput select 0];
_userInput = [_userInput] call CommandLine_fnc_alphaToAlpha;

_quit = ["Q","U","I","T"];
_help = ["H","E","L","P"];
_time = ["T","I","M","E"];
_whoami = ["W","H","O","A","M","I"];
_color = ["C","O","L","O","R"];
_ls = ["L","S"];

switch true do {
	case(str(_userInput) == str(_quit)):{
		_output = ["QUIT"];
	};
	case(str(_userInput) == str(_help)):{
		_output = ["HELP"];
	};
	case(str(_userInput)==str(_time)):{
		_output = ["TIME"];
	};
	case(str(_userInput)==str(_whoami)):{
		_output = ["WHOAMI"];
	};
	case(str(_userInput)==str(_color)):{
		_output = ["COLOR"];
	};
	case(str(_userInput) == str(_ls)):{
		_output = ["LS"];
	};
};

_output;