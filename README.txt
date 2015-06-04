README.txt
Arma Terminal 0.1.0

For best viewing of this document, view in notepad, notepad++ or your operating system's equivalent program

Table of Contents

0.  What should I look at in here
1.  What is a command line
2.  What is armaTerminal
3.  How to use armaTerminal
4.  How to use armaTerminal in your mission
5.  Known Bugs
6.  Change Log
7.  File list
7.5.Object contents
8.  Start Add Action
9.  Future Features

_____________________________________________________

0.What should I look at in here
	This is a comprehensive README that has information for first time users, mission developers, and eventually code developers once that opens up (see section 2)
	If you are a user, you will want to read sections 1,2,3,5,6,9
	If you are a mission developer, you will want sections 1,2,3,4,5,8,9
	To become more familiar with the code read sections 5,6,7,7.5,8,9
_____________________________________________________

1.What is a command line
	-A command line is the most basic view of an operating system (OS). Even windows 7 and 8.1 have command line views (start, search 'command prompt'). Command lines are quite basic but also quite powerful. You should not mess around in a command line if you do not know what you are doing. It is very easy to completely erase ALL your data or otherwise mess with it.
	-What makes the command line so special though is this power and the ease of access to it. Graphical systems such as your desktop and GUI applications (like Arma or notepad) dumb down what goes on behind the scenes so its easier for humans to interact with but harder for humans to make changes to the actual computer. Think of these programs as having training, wheels like on a bike, a command line, however, has no training wheels.
	-This means that commands that are cumbersome to access and use through gui systems (like control panel), are just a few keystrokes away in the command line. Unlike control panel however, unless you really know what you are doing, its a lot harder to undo changes in the command line, sometimes even impossible.
_____________________________________________________

2.What is armaTerminal
	The reason that I chose to make a command line OS rather than a graphical one is three fold. First off, I don't understand dialogues well (these would be the GUI components). Second, the command line seemed like it fit with ArmA better as it is easy to learn, hard to master. And Lastly, I wanted to learn about how command lines work, at least to some degree.
	Arma Terminal allows a player to access a Linux inspired command line in game and manipulate virtual files created by the mission maker and/or other players in the game world. This can lead to lots of new game play mechanics including vehicles for delivering story, hacking to get enemy intel, or even just more in depth objectives.
	Arma Terminal is not and should not be considered a fully fledged operating system or command line. It is still a work in progress and does not (and will not) contain all the commands necessary to support a full operating system. The commands that are implemented are designed to give players the tools to create, read, update, destroy, protect and hack the virtual files for mission game play. Any thing beyond that hasn't been implemented and niche commands probably never will be implemented by myself.
	Once release 1.0.0 happens, I will be opening up the code for anyone to modify so long as they give credit, before that point, unless I say otherwise, the only version out there should be my own. That said, slight modifications for specific missions are ok. (i.e. changing it so a user is already logged in) Be smart about it :)
_____________________________________________________

3.How to use armaTerminal
	Arma Terminal has been designed to be easy to learn difficult to master. When you open Arma Terminal, it will have a blurb at the top to type 'help' if you need  help. For experienced command line users, this will not need to be said, but for people new to a command line, I suggest following the advice. Typing 'help' will print out all the commands and a short blurb about what they do.
	To use a command line, type a command into the line. Once the command is fully typed out, you hit enter/return to confirm it. Once confirmed the computer processes the line and executes the command. Once it is finished processing, it will either prompt the user for more input or display another empty line.
_____________________________________________________

4.How to use armaTerminal in your mission
	Using Arma terminal in your mission is quite simple, at least compared to coding it all yourself :) The steps are as follows:
		1.  Take the armaTerminal.sqf, functions folder, and description.ext and drag them into your mission folder.
		1a. If your mission already has a description.ext, you can just copy all the code in my description.ext into yours.
		2.  Place down a computer (any object in game will do, even a pile of bricks or player, but a computer will add to the authenticity) and add the code from section 8 in this readme to the init field of the object.
		3.  Go in game and open up Arma Terminal. Use the in game commands to create the users and file structure that you want.
		4.  Once you have the computer in the state you want it, type 'ctc' into the command line and hit enter. This will copy all the data you need to your clip board. This is only possible from dev mode. When you copy the code to your clipboard, it will set the boolean for dev mode false so that players cannot do this in the mission.
		5.  With the code copied go into your mission and take out all the code you added in step 2 to its init field. Paste in the code that you got from in game.
		6.  Test your mission and the computer to make sure they are working properly.
		7.  If you need to make any more modifications to the terminal, just go into the init field and change the last boolean in the add action from false to true. Then you can continue to edit your terminal until its the way you want it.
_____________________________________________________

5.Known Bugs
	-It is unknown if this is MP compatible. I am not able to test on a server with multiple people. If it does break in MP let me know and I will try to fix this. I do want this to work in MP.(not really a bug but this is the best place to put this)
	-When you delete a user, if they had exclusive access to any files, their files will not be usable. This can be remedied by making a user with the old user's user name and deleting the files manually.
		-This is a minor bug, but tedious to fix, it will get done eventually, but large features will have more impact to the terminal than this minor issue.
	-Typing '<' in the terminal or in STEED will prevent any text after the '<' from being displayed unless followed by 'br/>'. This is believed to be a limitation of the engine with the display method I am using. As such, you cannot type '<' in ArmaTerminal.
	-The text will truncate after a certain length is reached (over 2000 characters, possibly as far out as 5000). The text is still processed just not rendered. Pressing Control + X in the terminal, will wipe all previous lines so new text will be rendered for the time being.
	-Key modifiers (control and shift) sometimes don't register when pressed. This is an engine limitation. If I find a better solution, I will fix it, but just be persistent for now.
	
_____________________________________________________

6.Change Log
	V 0.1.0 : FIRST RELEASE
		-Command Line Implemented
			-Help Command Added
			-Quit Command Added
			-Time Command Added
			-Display User Command Added
			-Text Color Command Added
			-List Files Command Added
			-Open File Command Added
			-Rename File Command Added
			-Make Directory Command Added
			-Delete Directory Command Added
			-Open Text Editor Command Added
			-Text Editor Help Command Added
			-Add User Command Added
			-Login Command Added
			-Logout Command Added
			-Permission Modification Command Added
			-User Delete Command Added
			-Dev Command Added
			-Clear Text Command Added
		-Text Editor Implemented
			-Can Exit Text Editor
			-Can Save File in Text Editor
			-Can Move Cursor in Text Editor
			-Can Copy Text from Text Editor
			-Can Paste Text into Text Editor (overwrites file)
			-Can Delete Characters
		-State based printing added
		-Scrolling added
		-Directory File Type Added
		-Text Document File Type Added
		-Multi-Line Command Support Added
		-Line parsing Added
_____________________________________________________

7.File List
	-ArmaTerminal.sqf - The file called from the game, contains calls to open and close the terminal along with the logic loop.
	-Functions - Contains several folders with all of the functions for Arma Terminal. The functions contain all the logic.
		- Command Line - Contains the command line logic.
			-fn_alphaToAlpha.sqf - converts input arrays to all caps
			-fn_executeLine.sqf - A known god class. Takes in input and the computer and returns the new state of the computer. Does all the operational command line logic.
			-fn_getCommand.sqf - compares input array with known commands and returns a string representing the command.
			-fn_getCurrentDir.sqf - Probably should have been in file. Gets the current directory that the user is in.
			-fn_newCommandLine.sqf - 'Creates' a new commandLine. In reality it composes an array with all of the fields for commandLine and returns it.
			-fn_processUserInput.sqf - Handles the logic when a key is pressed in the commandLine.
		- Computer - Contains the logic for low level operations in the terminal.
			-fn_close.sqf - Closes the computer and returns the user to the normal game.
			-fn_getUserInput.sqf - Processes which key(s) are being pressed.
			-fn_open.sqf - 'Creates' a new computer. In reality it composes an array with all of the fields for computer and returns it.
			-fn_print.sqf - Prints the proper text to the screen so the user can see what's going on.
		- File - Contains the logic for dealing with files.
			-fn_getFile.sqf - Takes a directory and file name and returns the file with the matching file name.
			-fn_getFileIndex.sqf - Rarely used, but crucial. Takes a directory and file name and returns the index of the file with the matching name.
			-fn_getType.sqf - Rarely used, but crucial. Takes a file and returns weather it is a document or directory.
		- Line - Contains the logic for the individual lines that compose the command line.
			-fn_inputToString.sqf - Takes in an input array and returns it in string form.
			-fn_newLine.sqf - Creates a new line for the command line.
			-fn_parseFilePath.sqf - Takes in the file path, parses it and returns an array with each file in the path.
			-fn_parseSpaceDeliniation.sqf - Takes in an input array and parses it for spaces with backslash ('\') as the escape character.
			-fn_pop.sqf - Takes in a stack and returns the top element and pops it.
			-fn_push.sqf - Takes a stack and an element and pushes the element to the top of the stack.
		- Steed - Contains the logic for the built in text editor
			-fn_newSteed.sqf - Creates a new STEED.
			-fn_processUserInput.sqf - Handles the logic when a key is pressed in STEED
	-Description.ext - The declarations for all of the 'classes' and functions. SQF is not an OO language hence the quotes.
	-README.txt - This file.
_____________________________________________________

7.5.Object Contents
	Sqf is not an OO language, however it does have a very loose object system. The following is the contents of the different arrays that constitute objects in ArmaTerminal
		- Computer = [List of all users, File structure, Current user, Computer name, State of the computer (commandLine/steed/quit), Command line, Text color, Text editor, Whether or not the computer is in dev mode]
		- Command Line = [Array of all previous lines, An array of chars that is the current line, the file path to the current directory, all previously input commands, index of where user is in list of previous commands, the yOffset for scrolling the text, A cache for storing data for multi line operations, weather or not the input should be starred out (i.e. a password)]
		- Line = [Text before the semicolon, Text after the semicolon] (assuming ':' is a semi colon)
		- File - There are two types of files
			-Document = [File Name, Contents, Permission(s)]
			-Directory = [File Name, Array of sub directories, Permission(s)]
		- STEED (text editor) = [Name of file being edited, header displayed to user at top of document, all text before the cursor, all text after the cursor, y offset for scrolling, permission(s) of the file];
_____________________________________________________

8.Start Add Action
	The following line is the add action for a base computer. It has only a MASTER directory and no users.
	
	this enableSimulation false;this addAction["Use Computer","armaTerminal.sqf",[[],["MASTER",[],"PUBLIC"],true]];
	
_____________________________________________________

9.Future Features (Hopefully) (In no particular order)
	-Networking								~V 0.3.0
	-Actual hacking (Coding support)		~V 0.5.0
	-Portable laptops						~V 0.3.0
	-Simulated Hard drives					~V 0.3.0
	-Proper tab key							~V 0.2.0
	-Proper caps key						~V 0.2.0
	-Proper document navigation in steed	~V 0.2.0
	-Self scrolling terminal				~V 0.2.0
	-A Disk Format command					~V 0.2.0
	-User groups							~V 0.2.0
	-Proper read and write permissions		~V 0.2.0
	-UAV hacking / interaction				~V 0.4.0
	-Simulated boot and shut-down sequence	~V 0.3.0
	-Admin User(s)							~V 0.2.0
	-Highlight text in STEED				~V 0.2.0
	-Hex support for color command 			~V 0.2.0