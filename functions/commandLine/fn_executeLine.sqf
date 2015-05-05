/*
 * Takes a command value and any parameters and executes the command with given perimeters.
 * It also takes in the computer to allow for operations on the computers state
 * It returns the output line of the command, and the updated computer
 * In some cases, it might modify commandLines cache for multi line operations
 */

private [_arg,_computer];

_arg = _this select 0;
_cmd = _arg select 0;
_computer = _this select 1;

_commandLine = _computer select 5;
_cache = _commandLine select 6;

_remainingLine = [_arg select 1] call Line_fnc_inputToString;
_params = [_remainingLine] call Line_fnc_parseSpaceDeliniation;

_output = "The command you entered is not recognised as a command. Type 'HELP' in order to see a list of supported commands.";

if(!(_cache select 0))then{
	switch true do {
		case(str(_cmd) == str("QUIT")):{
		
			_computer set[4,"QUIT"];
			
			_output = "";
		};
		case(str(_cmd) == str("HELP")):{
			_output = "Supported Commands:<br/>"+
				"  HELP           Displays all supported commands<br/>"+
				"  TIME           Displays the current date and time   m/d/y hr:min<br/>"+
				"  WHOAMI        Displays the current active user's user name <br/>"+
				"  COLOR         Toggles color of text between green and white<br/>"+
				"  LS             Displays all files in current active directory<br/>" +
				"  CD [DirName]   Opens the specified directory, no [] braces, 'cd ..' returns you to the parent directory<br/>" +
				"  RN [DirName] [NewName]   Renames the directory matching the first parameter with the name specified in the second parameter, no [] braces<br/>" +
				"  MKDIR [DirName] Creates a new directory in the current active directory with specified dirName, no [] braces<br/>" +
				"  RM [DirName]    permanently deletes the specified subdirectory from the current directory<br/>"+
				"  QUIT           Exits the terminal<br/>"+
				"When specifying arguments, the '\' key is the escape character. You can press this to allow for spaces in your arguments by typing '\ '";
		};
		case(str(_cmd) == str("TIME")):{
			_date = date;				// [year, month, day, hour, minute]
			_year = _date select 0;
			_month = _date select 1;
			_day = _date select 2;
			_hour = _date select 3;
			_minute = _date select 4;
			
			if(_minute < 10)then{ _minute = "0"+str(_minute);};				//Format time right
			
			_output = format ["%1/%2/%3  %4:%5",_month,_day,_year,_hour,_minute];
		};
		case(str(_cmd) == str("WHOAMI")):{
			_output = "No user currently logged in.";
			
			if(_computer select 2 != "PUBLIC")then{
				_output = _computer select 2;		//Get current User
			};
			
			_output;
		};
		case(str(_cmd) == str("COLOR")):{
			_color = _computer select 6;
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
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			_output = "";
			_inc = 0;
			
			{
				_inc = _inc + 1;				//To account for last line not needing a br
				_fileName = str(_x select 0);	//Converts from errorString to string with extra ""
				_fileName = _fileName select [1,(count _fileName - 2)];	//Removes extra ""

				if(_inc != count(_curDir select 1))then{		//if not the last subDirectory
					_output = _output + _fileName + "<br/>";
				}else{
					_output = _output + _fileName;
				};
			}forEach ([_curDir] call File_fnc_getContents);
			
			if(_output == "")then{
				_output = "No files in directory";
			};
			
			_output;
		};
		case(str(_cmd) == str("CD")):{
		
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			_fileName = [_arg select 1] call Line_fnc_inputToString;
			_fileName = _params select 0;
			
			if(_fileName == ".." || _fileName == "../")then{
				if(count _filePath > 1)then{					//If not in MASTER
					_filePath set [count _filePath - 1, ""];
					_filePath = _filePath - [""];
					_output = "";
				}else{											//If in MASTER
					_output = "Already in root directory";
				};
			}else{
				_file = [_curDir,_fileName] call File_fnc_getFile;
				if(str(_file) != str(0))then{						//If you can find a file with specified name
					if(typeName(_file select 1) == "ARRAY")then{	//If specified file found and is a directory
						_filePath = _filePath + [_file select 0];
						_output = "";
					}else{											//If specified file found but not a directory
						_output = "Not a directory";
					};
				}else{												//If the specified file could not be found
					_output = "No such file or directory";
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
			
			_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			

			
			_prevName = _params select 0;
			_newName = _params select 1;
			
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
					_output = "File name changed from ''" + _prevName + "'' to ''" + _newName + "''.";
				};
			};
			
			_output;
		};
		case(str(_cmd)==str("MKDIR")):{
			_output = "";
			
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;

			_newFileName = _params select 0;
			
			switch(true)do{
				case(_newFileName == ""):{													//No file name given
					_output = "Unspecified File Name";
				};
				case(str([_curDir,_newFileName] call File_fnc_getFile) != str(0)):{			//File name is already a file
					_output = "New file name already exists in current directory";
				};
				case(_newFileName != "" && str([_curDir,_newFileName] call File_fnc_getFile) == str(0)):{	//File name is unique in current directory
					_newFile = [_newFileName,[]];
					(_curDir select 1) set[count (_curDir select 1), _newFile];
				};
			};
			_output;
		};
		case(str(_cmd)==str("RM")):{
			_output = "";
			
			_commandLine = _computer select 5;
			_filePath = _commandLine select 2;
			_files = _computer select 1;
			
			_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
			
			_rmFile = _params select 0;
			
			switch(true)do{
				case(_rmFile == ""):{												//No file name specified
					_output = "Unspecified file name";
				};
				case(str([_curDir,_rmFile] call File_fnc_getFile) == str(0)):{		//Specified name does not exist
					_output = "Specified file name does not exist";
				};
				case(str([_curDir,_rmFile] call File_fnc_getFile) != str(0)):{		//Specified file name does exist
					_output = "Deleting this file will permanently erase all of its contents.";
					_cache = [true, "RM", "Confirm you want to delete this file (y/n) : ",_rmFile];
					_commandLine set[6,_cache];
					//Doesnt actually remove the file in this function, simply caches data for later
				};
			};
			_output;
		};
	};
}else{
	_output = "Not a valid command";
	switch(true)do{
		case(str(_cache select 1) == str("RM")):{			//Cache has data and RM cached it			
			if(str(_cache select 4) == str(["Y"]))then{		//User input y for yes

				_commandLine = _computer select 5;
				_filePath = _commandLine select 2;
				_files = _computer select 1;

				_curDir = [_files, _filePath] call CommandLine_fnc_getCurrentDir;
				_rmFile = [_curDir,_cache select 3] call File_fnc_getFile;
				_index = [_curDir, _rmFile select 0] call File_fnc_getFileIndex;
				_contents = _curDir select 1;		//Get file contents and modify it
				_contents set[_index, ""];
				_contents = _contents - [""];
				_curDir set[1, _contents];			//Up date file structure through reference
				
				_output = "File deleted";
			};
			
			if(str(_cache select 4) == str(["N"]))then{		//User input N for no
				_output = "File not deleted";
			};
			
			_cache = [false];
			_commandLine set[6,_cache];
			_output;
		};
	};
	_output;
};


[_output,_computer];