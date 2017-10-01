/*
 *	Joshua Shear
 *	Computer_fnc_open.sqf
 *	Takes in the computer object, the player, the actionID, the list of users for the computer, the file structure for the computer, and weather or not the computer is in dev mode
 *	Creates a new computer instance with all necessary variables and blacks out screen for text.
 *	
 *	How to call : [_target,_caller,_actionID] call Computer_fnc_open;
 *  
 *  
 *	
 *	Returns : A computer
 *	
 *	Function Calls:
 *		CommandLine_fnc_newCommandLine
 *		Steed_fnc_newSteed
*/

#define GET _target getVariable
#define KEYLOGUP(DISPLAY) (findDisplay DISPLAY) displayAddEventHandler["KeyUp", { player setVariable ["pressedKey", (_this select 1)]; player setVariable ["shift", (_this select 2)]; player setVariable ["control", (_this select 3)];}]
#define KEYLOGDOWN(DISPLAY) (findDisplay DISPLAY) displayAddEventHandler["KeyDown", {true}]

private _target = _this select 0;						//Computer
private _caller = _this select 1;						//Player Activating computer
private _actionID = _this select 2;						//Action ID

_caller action ["SwitchWeapon", _caller, _caller, 100];	//Makes _caller switch to no weapon (holster pistol/put rifle on back)
/* ^Code Courtesy of KillzoneKid^ */

_target removeAction _actionID;							//Removes open action to prevent the competing console bug
sleep 2.3;												//Wait for animation

//Var Init
private _users = GET "Users";							//Users registered with computer
private _files = GET "AFS";								//Starting File Structure
private _currentUser = GET "CurUser";					//UserID or PUBLIC (If no user logged in)
private _computerName = GET "ComputerName";				//name of the computer (UNUSED UNTILL NETWORKING UPDATE)
private _state = "COMMANDLINE";							//State that the computer is in (COMMANDLINE, EDITOR, QUIT)
private _commandLine = GET "CommandLine";				//Command Line object stored
if(str(_commandLine) == str([]))then{
	_commandLine = [] call CommandLine_fnc_newCommandLine;	//Creates the command line for the system
}else{
	createDialog "Terminal";
};
private _color = GET "ComputerColor";					//Text color (by default green) (can be toggled to white)
private _steed = GET "STEED";							//Text editor stored ([] by default)
private _devMode = GET "devMode";						//Whether armaTerminal is in dev mode




[
	_users,
	_files,
	_currentUser,
	_computerName,
	_state,
	_commandLine,
	_color,
	_steed,
	_devMode
];