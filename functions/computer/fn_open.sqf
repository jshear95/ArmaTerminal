/*
 *	Joshua Shear
 *	Computer_fnc_open.sqf
 *	Takes in the computer object, the player, the actionID, the list of users for the computer, the file structure for the computer, and weather or not the computer is in dev mode
 *	Creates a new computer instance with all necessary variables and blacks out screen for text.
 *	
 *	How to call : [_target,_caller,_actionID,_users,_files,_devMode] call Computer_fnc_open;
 *	
 *	Returns : A computer
 *	
 *	Function Calls:
 *		CommandLine_fnc_newCommandLine
 *		Steed_fnc_newSteed
*/

private [_target,_caller,_actionID,_users,_files,_currentUser,_computerName,_state,_commandLine,_color,_textEditor,_devMode];

_target = _this select 0;						//Computer
_caller = _this select 1;						//Player Activating computer
_actionID = _this select 2;						//Action ID
_users = _this select 3;						//Users registered with computer
_files = _this select 4;						//Starting File Structure
_devMode = _this select 5;						//Boolean for weather or not armaTerminal is in dev mode

_caller action ["SwitchWeapon", _caller, _caller, 100];		//Makes _caller switch to no weapon (holster pistol/put rifle on back)
/* ^Code Courtesy of KillzoneKid^ */

sleep 2.3;													//Wait for animation
_caller enableSimulation false;								//Prevents player from undoing the weapon switch

_target removeAction _actionID;					//Removes open action to prevent the competing console bug

cutText ["", "BLACK FADED",0];					//Fades screen to black

//Var Init
_currentUser = "PUBLIC";					//UserID or PUBLIC (If no user logged in)
_computerName = "ION Secure Device";		//Name of the computer (UNUSED TILL NETWORKING UPDATE)
_state = "COMMANDLINE";						//State that the computer is in (COMMANDLINE, EDITOR, QUIT)
_commandLine = [] call CommandLine_fnc_newCommandLine;	//Creates the command line for the system
_color = "#33CC33";							//Text color (by default green) (can be toggled to white)
_textEditor = ["NO DOCUMENT",[""],"PUBLIC"] call Steed_fnc_newSteed;	//Strategic TExt EDitor for editing text and code files


[
	_users,					//All users registered on the computer
	_files,					//All files on the computer
	_currentUser,
	_computerName,
	_state,
	_commandLine,
	_color,
	_textEditor,
	_devMode
];