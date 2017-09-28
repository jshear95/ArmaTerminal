/*
 *	Joshua Shear
 *	Computer_fnc_close.sqf
 *	Closes the command line and restores the screen
 *	
 *	How to call : [_target, _caller, _devMode] call Computer_fnc_close;
 *	
 *	Returns : nothing
 *	
 *	Function Calls
 *		NONE
*/

private _target = _this select 0;													//Computer
private _caller = _this select 1;													//Player Activating computer
private _devMode = _this select 2;													//Weather or not the computer is in dev mode


//while{dialog}do{};
closeDialog 1;																	//Close Terminal
_caller enableSimulation true;													//Re enables full game for player
_target addAction ["UseComputer","armaTerminal.sqf",[_users,_files,_devMode]];	//Restores action with all variables updated based on any user changes