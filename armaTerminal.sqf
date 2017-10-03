/**
 * ArmaTerminal V 0.1.0
 * armaTerminal.sqf
 * By Joshua Shear
 * Allows users to open computers and interface with virtual files and data through a Linux inspired command line and text editor
 *	
 *	How to call : With in-game add action OR  [_target, _caller,_actionID] execVM "armaTerminal.sqf";
 *	
 *	Returns : Nothing
 *	
 *	Calls:
 *		Computer_fnc_open
 *		Computer_fnc_getUserInput
 *		Steed_fnc_processUserInput
 *		CommandLine_fnc_processUserInput
 *		Computer_fnc_print
 *		Computer_fnc_close
 */

#define KEYLOGUP(DISPLAY) (findDisplay DISPLAY) displayAddEventHandler["KeyUp", { player setVariable ["pressedKey", (_this select 1)]; player setVariable ["shift", (_this select 2)]; player setVariable ["control", (_this select 3)];}]
#define KEYLOGDOWN(DISPLAY) (findDisplay DISPLAY) displayAddEventHandler["KeyDown", {true}]


//Get params
_target = _this select 0;					//Computer
_caller = _this select 1;					//Player Activating computer
_actionID = _this select 2;					//Action ID

//Creates computer object
_computer = [_target,_caller,_actionID] call Computer_fnc_open;

//Initializes Key Logger for basic input (THIS ONLY RECORDS INGAME KEYS)
_caller setVariable ["pressedKey",-1];
_caller setVariable ["shift",false];
_caller setVariable ["control",false];
_KeyUp46 = KEYLOGUP(46);
_KeyUp1 = KEYLOGUP(1);
_KeyDown46 = KEYLOGDOWN(46);
_KeyDown1 = KEYLOGDOWN(1);

/**
 * Execution loop
 * Runs for as long as user doesn't input quit and user is alive
 * Has a switch statement to get the given state and execute the proper commands for that given state (Command line, login, editor)
 */
 while{_computer select 4 != "QUIT"}do{
	//Gets key and logs it
	_input = -1;
	
	_pressedKey = (_caller getVariable "pressedKey");
	if(_pressedKey != -1 && _pressedKey != 54 && _pressedKey != 42)then{
		_shift = _caller getVariable "shift";
		_control = _caller getVariable "control";
		_input = [0, _pressedKey, _shift, _control,false] call Computer_fnc_getUserInput;
		
		_caller setVariable ["pressedKey",-1];
		_caller setVariable ["shift",false];
		_caller setVariable ["control",false];

		//Executes proper code for current state
		_state = _computer select 4;
		switch(str(_state)) do {
			case(str("EDITOR")) :{
				_computer = [_input, _computer] call Steed_fnc_processUserInput;
			};
			case(str("COMMANDLINE")):{
				_computer = [_input, _computer] call CommandLine_fnc_processUserInput;
			};
		};
		pressedKey = -1;
	};
	
	_print = [_computer] call Computer_fnc_print;
};

//Removes key event handlers so player can resume normal play
(findDisplay 1) displayRemoveEventHandler ["KeyDown", _KeyDown1];
(findDisplay 1) displayRemoveEventHandler ["KeyUp", _KeyUp1];
(findDisplay 46) displayRemoveEventHandler ["KeyDown", _KeyDown46];
(findDisplay 46) displayRemoveEventHandler ["KeyUp", _KeyUp46];


//Archives data into add action for future use
[_target,_caller,_computer] call Computer_fnc_close;
