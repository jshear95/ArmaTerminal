/*
 * Joshua Shear
 * CommandLine_fnc_executeLine.sqf
 * This is a known god class
 * Takes a command value and any parameters and executes the command with given perimeters.
 * It also takes in the computer to allow for operations on the computers state
 * It returns the output line of the command, and the updated computer
 * In some cases, it might modify commandLines cache for multi line operations
 *	
 *	How to call : [Array of processed input, computer] call CommandLine_fnc_executeLine;
 *	
 *	Returns : [Text to print into Command Line, computer]
 *	
 *	Function Calls:
 *		Line_fnc_inputToString
 *		Line_fnc_parseSpaceDeliniation
 *		CommandLine_fnc_getCurrentDir
 *		Steed_fnc_newSteed
 *		File_fnc_getFile
 *		File_fnc_getType
 *		File_fnc_getFileIndex
 *		File_fnc_hasReadPermission
 *		File_fnc_hasWritePermission
 */

private _arg = _this select 0;
private _cmd = _arg select 0;
private _computer = _this select 1;

private _commandLine = _computer select 5;
private _cache = _commandLine select 6;

private _users = _computer select 0;
private _user = _computer select 2;

private _remainingLine = [_arg select 1] call Line_fnc_inputToString;
private _params = [_remainingLine] call Line_fnc_parseSpaceDeliniation;

private _output = "The command you entered is not recognised as a command. Type 'HELP' in order to see a list of supported commands.";

if(!(_cache select 0))then{
	switch true do {
		case(str(_cmd) == str("QUIT")):{
			_computer set[4,"QUIT"];
			
			_output = "";
		};
		case(str(_cmd) == str("HELP")):{
			_output = "Supported Commands:<br/>"+
				"  HELP = Displays all supported commands<br/>"+
				"  CONTROL X = Clears all previous lines printed in the terminal<br/>"+
				"  TIME = Displays the current date and time   m/d/y hr:min<br/>"+
				"  WHOAMI = Displays the current active user's user name <br/>"+
				"  COLOR = Toggles color of text between green and white<br/>"+
				"  LS = Displays all files in current active directory<br/>" +
				"  LS -L = Displays all files in current active directory in the following<br/>        format: mod user file name<br/>" +
				"  CD [DirName] = Opens the specified directory, no [] braces,<br/>        'cd ..' returns you to the parent directory<br/>" +
				"  RN [DirName] [NewName] = Renames the directory matching the first parameter<br/>        with the name specified in the second parameter, no [] braces<br/>" +
				"  MKDIR [DirName] = Creates a new directory in the current active directory with<br/>        specified dirName, no [] braces<br/>" +
				"  RM [DirName] = permanently deletes the specified subdirectory from the current<br/>        directory<br/>"+
				"  STEED [FileName] = If specified file exists and is not a directory, opens it<br/>        in Simulated TExt EDitor (STEED), if the specified file does not exist,<br/>        it creates it and opens the new blank file in STEED<br/>" +
				"        For more information on steed, type 'HELP STEED' without the quotes<br/>"+
				"  USERADD = Prompts user for input for user name, password and password<br/>        confirmation, then generates a new user<br/>"+
				"  USERDEL = Prompts user for input for user name of user to delete, password of<br/>        user to delete, and current user's password, then deletes the specified<br/>        user<br/>"+
				"  LOGIN = Prompts user for input for user name and password, if both are<br/>        correct, logs in as user<br/>"+
				"  LOGOUT = Logs current user out and return to the master directory, if no user<br/>        is logged in, nothing happens.<br/>"+
				"  CHMOD [FileName] [Permissions] = Sets the file permission of the specified<br/>        file, to the specified parameter with the following:<br/>                0=No Permissions<br/>                1=Execute Only<br/>                2=Write Only<br/>                4=Read Only<br/>                Add numbers to combine permissions.<br/>        List three nubmers. The first number is for the file owner, the middle<br/>        is for other users, the last is for public users. An example is:<br/>                chmod file 740<br/>        this gives read write and execute access to the owner, read only access<br/>        to other users and no access to users not logged in. If a user is given<br/>        0 permissions, they will not be able to see the file. All permissions<br/>        are recursive on any files within the specified file.<br/>"+
				"  QUIT = Exits the terminal<br/>"+
				"When specifying arguments, the '\' key is the escape character. You can press this to allow for spaces in your arguments by typing '\ '";
		};
		case(str(_cmd) == str("TIME")):{
			private _date = date;				// [year, month, day, hour, minute]
			private _year = _date select 0;
			private _month = _date select 1;
			private _day = _date select 2;
			private _hour = _date select 3;
			private _minute = _date select 4;
			
			if(_minute < 10)then{ _minute = "0"+str(_minute);};				//Format time right
			
			_output = format ["%1/%2/%3  %4:%5",_month,_day,_year,_hour,_minute];
		};
		case(str(_cmd) == str("WHOAMI")):{
			_output = "No user currently logged in.";
			
			if(_user != "PUBLIC")then{
				_output = "Logged in as " + _user;		//Get current User
			};
			
			_output;
		};
		case(str(_cmd) == str("COLOR")):{
			private _color = _computer select 6;
			_output = "";
			
			if(_color == "#33CC33")then{
				_color = "#FFFFFF";			//White
			}else{
				_color = "#33CC33";			//Green
			};
			
			_computer set [6, _color];
			
			_output;
		};
		case(str(_cmd) == str("LS")):{
			_output = "";
			private _line = "";
			_commandLine = _computer select 5;
			private _filePath = _commandLine select 2;
			_files = _computer select 1;
			private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			
			{
				if([_x,_user] call File_fnc_hasReadPermission)then{					//Check for read permission of current directory
					private _fileName = str(_x select 0);							//Converts from errorString to string with extra ""
					_fileName = _fileName select [1,(count _fileName - 2)];			//Removes extra ""
					if(_params select 0 == "")then{
						_output = _output + _fileName + "<br/>";
					}else{
						private _name = str(_x select 2);
						_name = _name select [1, (count _name) - 2];
						if((count _name) > 20)then{
							_name = (_name select [0, 20]) + "...";
						};
						if((count _name) < 23)then{
							for "_x" from count _name to 22 do{
								_name = _name + " ";
							};
						};
						_output = _output + str(_x select 3 select 0) + str(_x select 3 select 1) + str(_x select 3 select 2) + " " + _name;
						_output = _output + " " + _fileName + "<br/>";
					};
				};
			}forEach (_curDir select 1);
			
			if(_output == "")then{
				_output = "No files in directory";
			}else{
				_output = _output select [0, ((count _output) - 5)];
			};
			
			_output;
		};
		case(str(_cmd) == str("CD")):{
		
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			private _fileName = _params select 0;
			
			if(_fileName == ".." || _fileName == "../")then{
				if(count _filePath > 1)then{					//If not in MASTER
					_filePath set [count _filePath - 1, ""];
					_filePath = _filePath - [""];
					_output = "";
				}else{											//If in MASTER
					_output = "Already in root directory";
				};
			}else{
				private _file = [_curDir,_fileName] call File_fnc_getFile;
				
				switch(true)do{
					case(str(_file)==str(0)):{
						_output = "No such file or directory";
					};
					case(not ([_file,_user] call File_fnc_hasReadPermission)):{
						_output = "No such file or directory";
					};
					case(!([_file] call File_fnc_getType)):{
						_output = "Not a directory";
					};
					case(str(_file) != str(0) && [_file,_user] call File_fnc_hasReadPermission):{
												//File exists, its a directory, and you have permission
						_filePath = _filePath + [_file select 0];	//append desired file to file path
						_output = "";
					};
				};
			};
			
			_commandLine set[2, _filePath];
			_computer set[5, _commandLine];
			
			_output;
		};
		case(str(_cmd) == str("RN")):{
			
			_output = "";
			
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			
			private _prevName = _params select 0;
			private _newName = _params select 1;
			if(str([_curDir,_prevName] call File_fnc_getFile) != str(0) and ([[_curDir,_prevName] call File_fnc_getFile,_user] call File_fnc_hasWritePermission))then{
																							//File exists and curUser has write permission
				switch(true)do{
					case(str([_curDir,_prevName] call File_fnc_getFile) == str(0)):{		//If no file name given
						_output = "Unspecified File Name";
					};
					case(count _params < 2):{												//If no new file name given
						_output = "No new name specified for file";
					};
					case(str([_curDir,_newName] call File_fnc_getFile) != str(0)):{			//If the new file name exists in the current directory
						_output = "New file name already exists in current directory";
					};
					case(str([_curDir,_prevName] call File_fnc_getFile) != str(0)):{		//If the file exists and the new name is not in the current directory
						_theFile = [_curDir,_prevName] call File_fnc_getFile;
						_theFile set[0, _newName];											//By a miracle, sqf understood that I wanted a reference and not a copy for this variable
																							//the file structure is updated from this line
						_output = "File name changed from '" + _prevName + "' to '" + _newName + "'.";
					};
				};
			}else{
				if(str([_curDir,_prevName] call File_fnc_getFile) != str(0) and not ([[_curDir,_prevName] call File_fnc_getFile,_user] call File_fnc_hasReadPermission))then{
																							//File exists and current user does not have read permission
					_output = "Specified file not found.";
				}else{
					_output = "You lack the permissions to rename this file.";
				};
			};
			
			_output;
		};
		case(str(_cmd)==str("MKDIR")):{
			_output = "";
			
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			private _newName = _params select 0;
			if([_curDir,_user] call File_fnc_hasWritePermission)then{
				
				switch(true)do{
					case(str(_params) == str([])):{
						_output = "Unspecified File Name";
					}; 
					case(_newName == ""):{							//No file name given
						_output = "Unspecified File Name";
					};
					case(str([_curDir,_newName] call File_fnc_getFile) != str(0)):{			//File name is already a file
						_output = "Error creating file";
					};
					case(_newName == "MASTER"):{											//New file name is MASTER
						_output = "MASTER cannot be used as a subdirectory name, MASTER is reserved for the root directory";
					};
					case(_newName != "" && str([_curDir,_newName] call File_fnc_getFile) == str(0)):{	//File name is unique in current directory
						_newFile = [_newName,[],_user,[7,0,0]];
						if(str(_user) == str("PUBLIC"))then{_newFile set [3,[7,7,7]]};	//If user is not logged in, anyone can do anything to the file
						(_curDir select 1) set[count (_curDir select 1), _newFile];
					};
				};
			}else{
				_output = "You do not have permission to create files in this directory";
			};
			_output;
		};
		case(str(_cmd)==str("RM")):{
			_output = "";
			
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			private _rmFile = _params select 0;
			
			if(str([_curDir,_rmFile] call File_fnc_getFile) != str(0) and [[_curDir,_rmFile] call File_fnc_getFile,_user] call File_fnc_hasWritePermission)then{
																						//File exists and current user has write permission
				switch(true)do{
					case(_rmFile == ""):{												//No file name specified
						_output = "Unspecified file name";
					};
					case(str([_curDir,_rmFile] call File_fnc_getFile) == str(0)):{		//Specified name does not exist
						_output = "Specified file name does not exist";
					};
					case(str([_curDir,_rmFile] call File_fnc_getFile select 2) != str("PUBLIC") && str([_curDir,_rmFile] call File_fnc_getFile select 2) != str(_user)):{
																						//You do not have permission to remove the specified file
						_output = "You lack the required permission to delete the specified file";
					};
					case(str([_curDir,_rmFile] call File_fnc_getFile) != str(0)):{		//Specified file name does exist
						_output = "Deleting this file will permanently erase all of its contents.";
						_cache = [true, "RM", "Confirm you want to delete this file (y/n) : ",_rmFile];
						_commandLine set[6,_cache];
						//Doesn't actually remove the file in this function, simply caches data for later
					};
				};
			}else{
				if(str([_curDir,_rmFile] call File_fnc_getFile) != str(0) and not ([[_curDir,_rmFile] call File_fnc_getFile,_user] call File_fnc_hasReadPermission))then{
					_output = "Specified file not found.";
				}else{
					_output = "You lack the permissions to delete this file.";
				};
			};
			_output;
		};
		case(str(_cmd)==str("STEED")):{
			_output = "";
			
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			private _fileName = _params select 0;
			private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			
			_file = [_fileName,[""],_user,[7,4,0]];
			if(_user == "PUBLIC")then{
				_file set [3,[7,7,7]];
			};
			_steed = _computer select 7;

			switch(true)do{
				case(_fileName == ""):{														//No file name given
					_output = "Unspecified File Name";
				};
				case(str([_curDir,_fileName] call File_fnc_getFile) != str(0) && not ([[_curDir,_fileName] call File_fnc_getFile,_user] call File_fnc_hasReadPermission)):{
																							//File name is already a file but user does not have read permission on it
					_output = "Specified file cannot be created.";
				};
				case(str([_curDir,_fileName] call File_fnc_getFile) == str(0) and [_curDir,_user] call File_fnc_hasWritePermission):{
																							//File name is not in current directory and user has write permission in current directory
					//Create skeleton file
					_file = [_fileName,[""],_user,[7,4,0]];
					if(_user == "PUBLIC")then{_file set [3,[7,7,7]]};						//If user is not logged in, anyone can do anything to the file
					_steed = [_file,_user,_curDir, false] call Steed_fnc_newSteed;
					_computer set[4,"EDITOR"];
				};
				case(str([_curDir,_fileName] call File_fnc_getFile) == str(0) && not ([_curDir,_user] call File_fnc_hasWritePermission)):{
																							//File not in current directory and current user does not have write access in current directory
					_output = "Specified file cannot be created.";
				};
				case(_fileName != "" && str([_curDir,_fileName] call File_fnc_getFile) != str(0) && [[_curDir,_fileName] call File_fnc_getFile] call File_fnc_getType):{
					_output = "Specified file name is already a directory";					//File name is a directory
				};
				case(str([_curDir,_fileName] call File_fnc_getFile) != str(0)):{			//File name is already a file and user has permission
					//get file
					_file = [_curDir,_fileName] call File_fnc_getFile;
					_steed = [_file,_user,_curDir, true] call Steed_fnc_newSteed;
					_computer set[4,"EDITOR"];
				};
			};
			_computer set[7,_steed];
			_output;
			
		};
		case(str(_cmd)==str("HELPSTEED")):{
			_output =	"Simulated TExt EDitor(STEED) HELP<br/>"+
						"  About: Steed is Arma Terminal's built in text editor. It has basic functionality<br/>          but should not be considered a full fleged text editor<br/>"+
						"  Commands:<br/>"+
						"    LEFT ARROW = Move the cursor left<br/>"+
						"    RIGHT ARROW = Move the cursor right<br/>"+
						"    CONTROL Z = Exit Steed (DOES NOT SAVE)<br/>"+
						"    CONTROL S = Save document (DOES NOT EXIT)<br/>"+
						"    HOME = returns the cursor to the beginning of the document<br/>"+
						"    END = brings the cursor to the end of the document<br/>"+
						"    BACKSPACE = Remove character behind cursor<br/>"+
						"    DELETE = Remove character in front of cursor<br/>"+
						"    PAGE UP = Scroll steed up<br/>"+
						"    PAGE DOWN = Scroll steed down<br/>"+
						"    CONTROL C = Copy entire document to clipboard, this allows you to paste into a<br/>                  full text editor such as Notepad or Microsoft Word<br/>"+
						"    CONTROL V = Pastes text in clipboard into the document (WARNING: THIS WILL<br/>                  OVERWRITE THE ENTIRE DOCUMENT, even if the text in the clipboard<br/>                  is shorter than the document)<br/>"+
						"  NOTE: No hints or warnings are displayed before saving or exiting, be careful not<br/>         to loose your work or overwrite anything important.";
		};
		case(str(_cmd)==str("USERADD")):{
			_output = "";
			_cache = [true, "USERADD0", "Specify User Name (Specify nothing to terminate command) : "];
			_commandLine set[6,_cache];
			_output;
		};
		case(str(_cmd)==str("LOGIN")):{
			if(str(_user) == str("PUBLIC"))then{
				_output = "";
				_cache = [true, "LOGIN0", "Enter User Name : "];
				_commandLine set[6,_cache];
			}else{
				_output = "User already logged in, log out before you log on to another user"
			};
			_output;
		};
		case(str(_cmd)==str("LOGOUT")):{
			if(str(_user)!=str("PUBLIC"))then{
				_output = "User logged out, returned to MASTER directory";
				
				_user = "PUBLIC";
				_computer set [2, _user];
				
				_filePath = ["MASTER"];			//Prevents logging out and being in a forbidden directory
				_commandLine set[2, _filePath];
			}else{
				_output = "No user logged in";
			};
			_output;
		};
		case(str(_cmd)==str("CHMOD")):{
			_output = "";
			
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			
			private _fileName = _params select 0;
			private _perms = _params select 1;			//Specified Permission
			
			switch(true)do{
				case(str(_user) == str("PUBLIC")):{										//If not logged in
					_output = "You are not logged in";
				};
				case(str([_curDir,_fileName] call File_fnc_getFile) == str(0)):{			//If no file name given
					_output = "Unspecified File Name";
				};
				case(count _params < 2):{												//If no new file name given
					_output = "No permission specified for the file";
				};
				case(str(([_curDir,_fileName] call File_fnc_getFile) select 2) != str("PUBLIC") && str(([_curDir,_fileName] call File_fnc_getFile) select 2) != str(_user) && str(_user) != str("admin")):{
																						//You do not have permission to remove the specified file
					_output = "You lack the required permission to rename the specified file";
				};
				case(str([_curDir,_fileName] call File_fnc_getFile) != str(0)):{
																						//File exists
					_perms = str(_perms);
					private _i = count _perms;

					if(_i == 5)then{
						_perms =[_perms select [1,1],_perms select [2,1],_perms select [3,1]];
						_i = 0;
						{
							switch(true)do{				//Converts from string to int properly (all sqf functions leave the ints as strings contrary to what the documentation says)
								case(_x == "0"):{_perms set [_i, 0];};
								case(_x == "1"):{_perms set [_i, 1];};
								case(_x == "2"):{_perms set [_i, 2];};
								case(_x == "3"):{_perms set [_i, 3];};
								case(_x == "4"):{_perms set [_i, 4];};
								case(_x == "5"):{_perms set [_i, 5];};
								case(_x == "6"):{_perms set [_i, 6];};
								case(_x == "7"):{_perms set [_i, 7];};
								default{_perms set [_i, 8];};
							};
							_i = _i + 1;
						}forEach _perms;
					}else{
						_perms =[8,8,8];
					};
					private _bool = false;
					{
						if(_x > 7 or _x < 0)then{_bool = true;};
					}forEach _perms;
					if(_bool)then{
						_output = "Incorrect permission formatting. Check CHMOD in HELP for details.";
					}else{
						_theFile = [_curDir,_fileName] call File_fnc_getFile;
						_theFile set [3,_perms];
						_output = "File permissions updated";

					};
				};
			};
			
			_output;
		};
		case(str(_cmd)==str("USERDEL")):{
			_output = "";
			if(str(_user)!=str("PUBLIC"))then{
				_cache = [true, "USERDEL0", "Specify User Name of the account to delete (Specify nothing to terminate command) : "];
				_commandLine set[6,_cache];
			}else{
				_output = "You are not logged in";
			};
			_output;
		};
		case(str(_cmd)==str("CTC") && _computer select 8):{
			_str = "this enableSimulation false;this addAction["+str("Use Computer")+","+str("armaTerminal.sqf")+",["+str(_computer select 0)+","+str(_computer select 1)+",false]];";
			copyToClipboard _str;
			_output = "Copied";
		};
	};
}else{
	_output = "Not a valid command";
	switch(true)do{
		case(str(_cache select 1)==str("RM")):{				//Cache has data and RM cached it			
			if(str(_cache select 4) == str(["Y"]))then{		//User input y for yes

				_commandLine = _computer select 5;
				_filePath = _commandLine select 2;
				_files = _computer select 1;

				private _curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
				private _rmFile = [_curDir,_cache select 3] call File_fnc_getFile;
				private _index = [_curDir, _rmFile select 0] call File_fnc_getFileIndex;
				_contents = _curDir select 1;				//Get file contents and modify it
				_contents set[_index, ""];
				_contents = _contents - [""];
				_curDir set[1, _contents];					//Up date file structure through reference
				
				_output = "File deleted";
			};
			
			if(str(_cache select 4) == str(["N"]))then{		//User input N for no
				_output = "File not deleted";
			};
			
			_cache = [false];
			_commandLine set[6,_cache];
			_output;
		};
		case(str(_cache select 1)==str("USERADD0")):{
			switch(true)do{
				case(str(_cache select 3)==str([""])):{		//Input was null
					_output = "Action cancelled";
					_cache = [false];
					_commandLine set[6,_cache];
				};
				case(str([_cache select 3] call Line_fnc_inputToString)==str("PUBLIC")):{	//Input was "PUBLIC"
					_output = "User name cannot be 'PUBLIC'";
					_cache = [false];
					_commandLine set[6,_cache];
				};
				case(str([_cache select 3] call Line_fnc_inputToString)!=str("PUBLIC")):{
					private _userName = [_cache select 3] call Line_fnc_inputToString;
					private _bool = false;
					{
						if(str(_userName)==str(_x select 1))then{
							_bool = true;
						};
					}forEach _users;						//Search for user, if found, set _bool
					if(_bool)then{							//If username already in use
						_output = "User name already in use.";
						_cache = [true, "USERADD0", "Specify another User Name (Specify nothing to terminate command) : "];
						_commandLine set[6,_cache];
					}else{									//If username not in use
						_cache = [true, "USERADD1", "Specify User Password:",_userName];
						_commandLine set[6,_cache];
						_commandLine set[7, true];		//Set input to be stared out
						_output = "";
					};
				};
			};

			_output;
		};
		case(str(_cache select 1)==str("USERADD1")):{
			private _password = [_cache select 4] call Line_fnc_inputToString;
			_cache = [true, "USERADD2", "Confirm Password:", (_cache select 3), _password];
			_commandLine set[6,_cache];
			_output = "";
			_output;
		};
		case(str(_cache select 1)==str("USERADD2")):{
			private _confPassword =	[_cache select 5] call Line_fnc_inputToString;
			if(str(_confPassword)==str(_cache select 4))then{
				//Passwords match
				_commandLine set[7, false];		//make input not stared out
				_users set [count _users, [_confPassword, (_cache select 3)]];
				_computer set [0, _users];
				
				_cache = [false];
				_commandLine set[6,_cache];
				
				_output = "User created";
			}else{
				//Passwords dont match
				_cache = [true, "USERADD1", "Specify User Password:", (_cache select 3)];
				_commandLine set[6,_cache];
				_commandLine set[7, true];		//Set input to be stared out
				_output = "Passwords do not match.";
			};
			_output;
		};
		case(str(_cache select 1)==str("LOGIN0")):{
			_output = "";
			
			private _userName = [_cache select 3] call Line_fnc_inputToString;
			
			private _bool = false;
			{
				if(str(_userName)==str(_x select 1))then{
					_bool = true;
				};
			}forEach _users;
			
			if(_bool)then{
				_cache = [true, "LOGIN1", "Enter Password : ", _userName];
				_commandLine set[6,_cache];
				_commandLine set[7, true];		//Set input to be stared out
				_output = "";
			}else{
				_output = "Specified User Name does not exist";
				_cache = [false];
				_commandLine set[6,_cache];
			};
			
			_output;
		};
		case(str(_cache select 1)==str("LOGIN1")):{
			private _password = [_cache select 4] call Line_fnc_inputToString;
			private _userName = _cache select 3;
			
			private _bool = false;
			{
				if(str(_userName)==str(_x select 1) && str(_password) == str(_x select 0))then{
					_bool = true;
				};
			}forEach _users;
			
			_output = "";
			
			if(_bool)then{
				_user = _userName
			}else{
				_output = "Password incorrect";
			};
			
			_cache = [false];
			_commandLine set[6,_cache];
			_commandLine set[7, false];
			_computer set [2, _user];
			
			_output;
		};
		case(str(_cache select 1)==str("USERDEL0")):{
			_output = "";
			
			private _delUser = [_cache select 3] call Line_fnc_inputToString;
			private _bool = false;
			{
				if(str(_delUser)==str(_x select 1))then{
					_bool = true;
				};
			}forEach _users;
			
			if(_bool and _delUser != 'admin')then{
				_cache = [true, "USERDEL1", "Specify User Password : ",_delUser];
				_commandLine set[6,_cache];
				_commandLine set[7, true];		//Set input to be stared out
				_output = "";
			}else{
				_cache = [false];
				_commandLine set[6,_cache];
				if(_delUser == 'admin')then{
					_output = "Cannot delete admin"
				}else{
					_output = "Specified user does not exist";
				};
			};
			
			_output;
		};
		case(str(_cache select 1)==str("USERDEL1")):{
			_output = "";
			
			private _delPswd = [_cache select 4] call Line_fnc_inputToString;
			private _delUser = _cache select 3;
			
			private _bool = false;
			{
				if(str(_delUser)==str(_x select 1) && str(_delPswd)==str(_x select 0))then{
					_bool = true;
				};
			}forEach _users;
			
			if(_bool)then{
				_cache = [true, "USERDEL2", "Enter your password to complete : ",_delUser, _delPswd];
				_commandLine set[6,_cache];
				_commandLine set[7, true];		//Set input to be stared out
				_output = "";
			}else{
				_cache = [false];
				_commandLine set[6,_cache];
				_commandLine set[7, false];
				_output = "Incorrect password";
			};
		};
		case(str(_cache select 1)==str("USERDEL2")):{
			_output = "";
			
			private _Pswd = [_cache select 5] call Line_fnc_inputToString;
			private _delUser = _cache select 3;
			private _delPswd = _cache select 4;
			
			private _bool = false;
			{
				if(str(_User)==str(_x select 1) && str(_Pswd)==str(_x select 0))then{
					_bool = true;
				};
			}forEach _users;
			
			private _i = 0;										//Index of user to delete
			if(_bool)then{
				_bool = false;
				{										//Get User
					if(str(_delUser)==str(_x select 1) && str(_delPswd)==str(_x select 0))then{
						_bool = true;
					};
					
					if(!(_bool))then{
						_i = _i + 1;
					};
				}forEach _users;
				
				_users set[_i, ""];						//Remove User
				_users = _users - [""];
				_computer set [0, _users];
				
				if(str(_delUser)==str(_user))then{		//If logged in as user just deleted, log them out properly
					_computer set [2, "PUBLIC"];
					_filePath = ["MASTER"];				//Prevents logging out and being in a forbidden directory
					_commandLine set[2, _filePath];
				};
				
				_output = "User " + _delUser + " deleted";
			}else{
				_output = "Incorrect password";
			};
			
			_commandLine set[7, false];
			_cache = [false];
			_commandLine set[6,_cache];
		};
	};
	_output;
};

[_output,_computer];