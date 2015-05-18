/**
 * ArmaTerminal
 * armaTerminal.sqf
 * By Joshua Shear
 * Allows users to open computers and interface with virtual files and data through a Linux inspired command line and text editor
 */

//Get params
_target = _this select 0;					//Computer
_caller = _this select 1;					//Player Activating computer
_actionID = _this select 2;					//Action ID
_users = _this select 3 select 0;			//Users registered with computer
_files = _this select 3 select 1;			//Starting File Structure
_devMode = _this select 3 select 2;			//Weather armaTerminal is in dev mode

//Initializes Key Logger for basic input (THIS ONLY RECORDS INGAME KEYS DONT WORRY)

pressedKey = -1;
/*
 *This is the ID of the key from the action listener below
 */
shift = false;
control = false;

_KeyUp = (findDisplay 46) displayAddEventHandler ["KeyUp", {pressedKey = _this select 1; shift = _this select 2; control = _this select 3;}];
/*Handles input for program, searches for key release events*/
_KeyDown =(findDisplay 46) displayAddEventHandler ["KeyDown", {if((_this select 1) != 1)then{_handled = true; _handled}}];
/*Handles blocking input from affecting character in game while terminal is running*/

//Creates computer object
_computer = [_target,_caller,_actionID,_users,_files, _devMode] call Computer_fnc_open;

/**
 * Execution loop
 * Runs for as long as user doesn't input quit and user is alive
 * Has a switch statement to get the given state and execute the proper commands for that given state (Command line, login, editor)
 */
 while{_computer select 4 != "QUIT"}do{
	if(floor(time) mod 9 == 0)then{							//Refreshes black background every 9 seconds
		cutText ["", "BLACK FADED",0];						//fade screen to black
	};
	
	//Gets key and logs it
	_input = -1;
	
	if(pressedKey != -1 && pressedKey != 54 && pressedKey != 42)then{
		_input = [0, pressedKey, shift, control,false] call Computer_fnc_getUserInput;
		
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
(findDisplay 46) displayRemoveEventHandler ["KeyDown", _KeyDown];
(findDisplay 46) displayRemoveEventHandler ["KeyUp", _KeyUp];

//Archives data into add action for future use
[_target,_caller,_devMode] call Computer_fnc_close;
