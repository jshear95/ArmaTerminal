/*
 *	Joshua Shear
 *	Computer_fnc_close.sqf
 *	Closes the command line and restores the screen
*/

private [_target,_caller,_devMode];

_target = _this select 0;													//Computer
_caller = _this select 1;													//Player Activating computer
_devMode = _this select 2;													//Weather or not the computer is in dev mode


sleep 2;																		//Allows text to fade the same time as the black background
_caller enableSimulation true;													//Re enables full game for player
_target addAction ["UseComputer","armaTerminal.sqf",[_users,_files,_devMode]];		//Restores action with all variables updated based on any user changes
titleCut ["", "BLACK IN", 0];													//Returns screen to game