# ArmaTerminal V0.1.1 #

**Arma Terminal** is a Linux based command line operating system mod for Arma 3. Currently the project is not open source, however once core features are finished, the project will be made open source.

Please note that compatibility between different versions of ArmaTerminal is very hard to guarantee given the massive changes that often need to be implemented for adding new features.

### Core Features
 - **Virtual file structure** that users can create, delete and modify files
 - **Virtual Users** complete with read, write and execute permissions
 - **In game text editor** for creating and modifying text files
 - **Copy to clipboard function for developers** to flesh out the OS (create users, documents and directories) and then copy the init code for it to the clipboard so they can paste it in the init file of a laptop or similar object in game. (The copied version won't allow this feature so players on your map can't get the file system, see below for details)

### Major planned features
 - **Networking** allowing players in a multi-player environment to message and hack into different terminals on the same virtual network
 - **Built in coding language** to allow users to create programs that can be run in the command line (complete with syntax highlighting)
 - **Hacking UAVs** allow for players from the terminal to take over UAVs in game
Check the issues list for current list of features and bugs

### Uses for ArmaTerminal

It might not be initially apparent the different uses for Arma Terminal inside of an Arma mission. These are some of the uses I have thought of:

 - **Objective Intel Storage**
   - In the Zeus update we got access to placeable intel that could be inherently picked up and read. This was cool but honestly, other than terror networks trying to stay off the grid, who stores AARs and mission plans on paper, its all been computerized. This was the initial reason I made Arma Terminal. Not only can you store a lot of documents on a computer, but you can password protect it, and hide the login credentials on a piece of the placeable intel somewhere else in the base/safe house/terrain. This can add new dynamics to old 'collect the intel' missions.
   - Another use is for storing lore for the mission. Say you want to have an option for players to find out why a camp was destroyed but its not required. At an enemy base you could hide an AAR on an Arma Terminal. Or you could hide chat feed between an agent and their handler that make it easier to locate an HVT.
   - Further more in a multi player setting, one faction could be tasked with defending a laptop while the other team tries to access files on it. They would have to defend the person using the terminal while they hack in to find the data.
 - **UAV Hacking** (Not yet implemented)
   - Eventually I want to allow for players to connect to any UAV on the map. As this could be potentially game breaking, there will probably be a way to toggle this functionality to UAVs designated by the mission maker. (Note that UAV in this context also includes the UGVs, auto turrets and any other item controllable via the UAV terminals in game)
 - **Messaging System** (Not yet implemented)
   - This will allow for players to message each other across a network of terminals. This would be an alternative to the in game chat.

## How to use ArmaTerminal as a player

Arma Terminal has been designed to be easy to learn, difficult to master. To open Arma Terminal, approach the computer. When you get close an action menu action `open computer` will pop up. To open the terminal use the `open computer` option. When you open Arma Terminal, it will have a blurb at the top to type `help` if you need  help. For experienced command line users, this will not need to be said, but for people new to a command line, this will be very helpful. Typing `help` will print out all the commands and a short blurb about what each one does.

To use a command line, type a command into the line. Once the command is fully typed out, you hit enter/return to confirm it. Once confirmed the computer processes the line and executes the command. Once it is finished processing, it will either prompt the user for more input or display another empty line.

Do note, that passwords are not hashed (they are stored in plain text). This is the least secure way to store a password. As such please do not use any passwords you use in real life in the terminal. For instance instead of using your real life license plate number use a password like the longest in game shot you have made or your ingame character's name.

## How to use armaTerminal in your mission as a mission creator

 1. Take the `armaTerminal.sqf`, `functions` folder, `description.ext`, `defines.hpp`, and `dialog.hpp` and drag them into your mission folder.
    1. If your mission already has any of those files, you can just copy all the code from my version into yours (be careful with the .hpp files, these are very easy to mess up).
 2. Place down a computer (any object in game will do, even a pile of bricks or player, but a computer will add to the authenticity) and add the code from the end of this section of the readme to the init field of the object.
 3. Go in game and open up Arma Terminal. Use the terminal to customize it to your liking. Users, files, directories, permissions, logged in users and previous commands are all customizable. For now only wory about users and files, everything else we will be modifying in a later step.
    1. Note that if you do not log a user out, when the terminal is opened in the mission, the player will be logged in as that user
    2. You will probably want to change the password on the administratior to something less obvious than password to prevent players in your mission from accessing the administrator acount and wreaking havoc.
    3. Do note that passwords are not hashed (they are stored in plain text). This is the least secure way to store a password. As such, please do not use any passwords you use in real life in the terminal.
 4. Once you have the computer in the state you want it, type `ctc` into the command line and hit enter. This will copy all the data you need to your clip board. This is only possible from dev mode. When you copy the code to your clipboard, it will set the boolean for dev mode false so that players cannot do this in the mission.
 5. With the auto generated code from the console, go into a seperate text editor like notepad++, notepad or Visual Studio Code and paste the contents.
    1. First, look for all the semi colons (`;`) and indent new lines after them. (This step is not nessicary but greatly increases the readability).
    2. Second, find the `this setVariable ["CommandLine"` section.
    3. Next, replace this entire line with `this setVariable ["CommandLine", []];`.
    4. Do the same for `this setVariable ["STEED"` section, replace the entire section with `this setVariable ["STEED", []];`
    5. If you want to present the user with a new blank terminal, you can proceed to step 6 (of the outer indented area).
    6. Find the line that says `this setVariable ["devMode", false];` and change the `false` to `true`. This will allow us to continue editing the terminal in game.
    7. Take this code and paste it over the original code on your computer
    8. Go in game and continue cusomizing the terminal, this time type the commands you want the player to see into the terminal (i.e. show a user logging in, checking a text file and logging out)
    9. Once you are done type `ctc` into the command line and hit enter. This will copy all the data you input into your clip board.
    0. Paste this code into your text editor over the previous code. It is recomended to use a text editor that will highlight opening and closing braces.
    1. Find all the semi colons (`;`) and indent new lines after them (once again for readability)
    2. Find the line with `this setVariable ["CommandLine"`
    3. It is recomended to use a text editor that will highlight opening and closing braces
    4. Find the second set of sub braces, you should see something like the following `["MASTER/test : ","c","t","c"],`
    5. Remove the `,"c","t","c"`
    6. Find the end of the fourth set of sub braces, you should see the following `,[["c","t","c"]]`
    7. Remove `,[["c","t","c"]]`
    8. After the end of the fourth set of sub braces should be a number, decrement the number by one (i.e. if it was 32 replace it with 31) 
    9. Copy all of this code
 6. With the code copied go into your mission and replace all the code you added in step 2 with this code.
 7. Test your mission and the computer to make sure they are working properly.
 8. If you need to make any more modifications to the terminal, just go into the init field and change the last boolean in the add action from false to true. Then you can continue to edit your terminal until it is the way you want it.

Code for initializing the terminal:
`this setVariable ["Users", [["password","admin"]]];
this setVariable ["AFS", ["MASTER",[],"PUBLIC",[7,7,7]]];
this setVariable ["CurUser", "PUBLIC"];
this setVariable ["ComputerName", "ION Secure Device"];
this setVariable ["ComputerState", "COMMANDLINE"];
this setVariable ["CommandLine", []];
this setVariable ["Computercolor", "#33CC33"];
this setVariable ["STEED", []];
this setVariable ["devMode", true];
this addAction["Use Computer","armaTerminal.sqf", []];`

## Known Bugs
 - It is unknown if this is MP compatible. I am currently not able to test on a server with multiple people. If it does break in MP let me know and I will try to fix this. I do want this to work in MP.
   - V 0.1.1 and earlier will definitely not work properly in MP, later versions have not been tested in MP

## Change Log
 - V 0.1.0 : FIRST RELEASE
   - Command Line Implemented
     - Help Command Added
     - Quit Command Added
     - Time Command Added
     - Display User Command Added
     - Text Color Command Added
     - List Files Command Added
     - Open File Command Added
     - Rename File Command Added
     - Make Directory Command Added
     - Delete Directory Command Added
     - Open Text Editor Command Added
     - Text Editor Help Command Added
     - Add User Command Added
     - Login Command Added
     - Logout Command Added
     - Permission Modification Command Added
     - User Delete Command Added
     - Dev Command Added
     - Clear Text Command Added
   - Text Editor Implemented
     - Can Exit Text Editor
     - Can Save File in Text Editor
     - Can Move Cursor in Text Editor
     - Can Copy Text from Text Editor
     - Can Paste Text into Text Editor (overwrites file)
     - Can Delete Characters
   - State based printing added
   - Scrolling added
   - Directory File Type Added
   - Text Document File Type Added
   - Multi-Line Command Support Added
   - Line parsing Added
 - V 0.1.1 : File Permission Update
   - Permissions Edit Command Added
   - Change Owner Command Added
   - Change Password Command Added
   - Admin User Added
   - Readme Got Some Love
   - General Error Fixing (Arma updates caused several non critical errors that were fixed)

- V 0.1.2 : UI update
   - Changed how the terminal was displayed improving responsiveness (in most cases)
   - Changed how the terminal stores and retrieves session data to add more relivant cross session data
   - Updated README.md to reflect terminal data store changes
   - Changed how key presses are registered to increase the likelyhood of MP compatibility
   - Updated testing enviornment
   - Temporarily removed the Color command (it was not working with the new display method)
   - Fixed text truncating after a certian length (due to printing algorithm)
   - Fixed `<` character not being typable due to display method
