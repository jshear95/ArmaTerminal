/*
 *	Joshua Shear
 *	Computer_fnc_close.sqf
 *	Closes the command line and restores the screen
 *	
 *	How to call : [_target, _caller, _computer] call Computer_fnc_close;
 *	
 *	Returns : nothing
 *	
 *	Function Calls
 *		NONE
*/

private _target = _this select 0;													//Computer
private _caller = _this select 1;													//Player Activating computer
private _computer = _this select 2;													//computer object


_target setVariable ["Users", _computer select 0];
_target setVariable ["AFS", _computer select 1];
_target setVariable ["CurUser", _computer select 2];
_target setVariable ["ComputerName", _computer select 3];
_target setVariable ["ComputerState", "COMMANDLINE"];
_target setVariable ["CommandLine",  _computer select 5];
_target setVariable ["ComputerColor", _computer select 6];
_target setVariable ["STEED", _computer select 7];
_target setVariable ["devMode", _computer select 8];


closeDialog 1;																	//Close Terminal
_caller enableSimulation true;													//Re enables full game for player
_target addAction ["UseComputer","armaTerminal.sqf",[]];						//Restores action