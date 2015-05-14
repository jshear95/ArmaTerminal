/**
	Closes the command line and restores the screen
*/

private ["_target","_caller"];

	_target = _this select 0;					//Computer
	_caller = _this select 1;					//Player Activating computer

_screenClear = {										//Return to game
	titleCut ["", "BLACK IN", 0];						//fades the screen in
};

sleep 2;										//Allows text to fade the same time as the black background
_caller enableSimulation true;					//Re enables full game for player
_target addAction ["UseComputer","armaTerminal.sqf",[_users,_files]];
												//Restores action with all variables updated based on any user changes
_callScreenClear = [] call _screenClear;		//Returns screen to game