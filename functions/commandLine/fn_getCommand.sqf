/*
 *	Joshua Shear
 *	CommandLine_fnc_getCommand.sqf
 *	Takes in user input and evaluates it to get the command and any parameters.
 *	If input matches no command, it returns an error.
 *	
 *	How to call : [current Line] call CommandLine_fnc_getCommand;
 *	
 *	Returns : Output - contains string representation of input command followed by any parameters input
 *	
 *	Function Calls :
 *		CommandLine_fnc_alphaToAlpha
 */

private _userInput = _this select 0;
_output = ["ERROR"];

_userInput = _userInput - [_userInput select 0];
_userInput = [_userInput] call CommandLine_fnc_alphaToAlpha;

_quit = ["Q","U","I","T"];
_help = ["H","E","L","P"];
_time = ["T","I","M","E"];
_whoami = ["W","H","O","A","M","I"];
_color = ["C","O","L","O","R"];
_ls = ["L","S"];
_cd = ["C","D"," "];
_rn = ["R","N"," "];
_mkdir = ["M","K","D","I","R"," "];
_rm = ["R","M"," "];
_steed = ["S","T","E","E","D"," "];
_helpSteed = ["H","E","L","P"," ","S","T","E","E","D"];
_userAdd = ["U","S","E","R","A","D","D"];
_login = ["L","O","G","I","N"];
_logout = ["L","O","G","O","U","T"];
_chmod = ["C","H","M","O","D"," "];
_chown = ["C","H","O","W","N"," "];
_userDel = ["U","S","E","R","D","E","L"];
_pswd = ["P","A","S","S","W","D"];
_ctc = ["C","T","C"];

switch true do {
	case(str(_userInput) == str(_quit)):{
		_output = ["QUIT"];
	};
	case(str(_userInput) == str(_help)):{
		_output = ["HELP"];
	};
	case(str(_userInput) == str(_helpSteed)):{
		_output = ["HELPSTEED"];
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
	case(str(_userInput) == str(_userAdd)):{
		_output = ["USERADD"];
	};
	case(str(_userInput) == str(_userDel)):{
		_output = ["USERDEL"];
	};
	case(str(_userInput) == str(_login)):{
		_output = ["LOGIN"];
	};
	case(str(_userInput) == str(_logout)):{
		_output = ["LOGOUT"];
	};
	case(str(_userInput select[0,2]) == str(_ls)):{
		_output = ["LS",_userInput select [3,count _userInput - 1]];
	};
	case(str(_userInput select[0,3]) == str(_cd)):{
		_output = ["CD",_userInput select [3,count _userInput - 1]];
	};
	case(str(_userInput select[0,3]) == str(_rn)):{
		_output = ["RN",_userInput select [3,count _userInput - 1]];
	};
	case(str(_userInput select[0,6]) == str(_chmod)):{
		_output = ["CHMOD",_userInput select [6,count _userInput - 1]];
	};
	case(str(_userInput select[0,6]) == str(_chown)):{
		_output = ["CHOWN",_userInput select [6,count _userInput - 1]];
	};
	case(str(_userInput select[0,6])==str(_mkdir)):{
		_output = ["MKDIR",_userInput select [6,count _userInput - 1]];
	};
	case(str(_userInput select[0,3])==str(_rm)):{
		_output = ["RM",_userInput select [3,count _userInput - 1]];
	};
	case(str(_userInput select[0,6])==str(_steed)):{
		_output = ["STEED",_userInput select [6,count _userInput - 1]];
	};
	case(str(_userInput) == str(_pswd)):{
		_output = ["PSWD"];
	};
	case(str(_userInput) == str(_ctc)):{
		_output = ["CTC"];
	};
	
};


_output;