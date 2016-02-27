#ArmaTerminal V0.1.1
# 
**Arma Terminal** is a Linux based command line operating system mod for Arma 3. Currently the project is not open source, however once core features are finished, the project will be made open source.

Please note that compatibility between different versions of ArmaTerminal is very hard to guarantee given the massive changes that often need to be implemented for adding new features.

### Core Features
 - **Virtual file structure** that users can create, delete and modify files in
 - **Virtual Users** complete with read, write and execute permissions
 - **In game text editor** for creating and modifying text files
 - **Copy to clipboard function for developers** to flesh out the OS (create users, documents and directories) and then copy the init code for it to the clipboard so they can just paste it in the init file of a laptop or similar object in game. (The copied version won't allow this feature so players on your map can't get the file system)

### Major planned features
 - **Networking** allowing players in a multi-player environment to message and hack into different terminals on the same virtual network
 - **Built in coding language** to allow users to create programs that can be run in the command line (complete with syntax highlighting)
 - **Hacking UAVs** allow for players from the terminal to take over UAVs in game
Check the issues list for current list of features and bugs

## How to use armaTerminal

Arma Terminal has been designed to be easy to learn, difficult to master. To open Arma Terminal, approach the computer. When you get close an action menu action `open computer` will pop up. To open the terminal use the `open computer` option. When you open Arma Terminal, it will have a blurb at the top to type `help` if you need  help. For experienced command line users, this will not need to be said, but for people new to a command line, this will be very helpful. Typing `help` will print out all the commands and a short blurb about what each one does.

To use a command line, type a command into the line. Once the command is fully typed out, you hit enter/return to confirm it. Once confirmed the computer processes the line and executes the command. Once it is finished processing, it will either prompt the user for more input or display another empty line.

## How to use armaTerminal in your mission

 - Take the armaTerminal.sqf, functions folder, and description.ext and drag them into your mission folder.
   - If your mission already has a description.ext, you can just copy all the code in my description.ext into yours.
 - Place down a computer (any object in game will do, even a pile of bricks or player, but a computer will add to the authenticity) and add the code from the end of this section of the readme to the init field of the object.
 - Go in game and open up Arma Terminal. Use the in game commands to create the users and file structure that you want.
 - Once you have the computer in the state you want it, type `ctc` into the command line and hit enter. This will copy all the data you need to your clip board. This is only possible from dev mode. When you copy the code to your clipboard, it will set the boolean for dev mode false so that players cannot do this in the mission.
 - With the code copied go into your mission and take out all the code you added in step 2 to its init field. Paste in the code that you got from in game.
 - Test your mission and the computer to make sure they are working properly.
 - If you need to make any more modifications to the terminal, just go into the init field and change the last boolean in the add action from false to true. Then you can continue to edit your terminal until its the way you want it.

Code for initializing the terminal:
`this enableSimulation false; this addAction["Use Computer","armaTerminal.sqf",[[["password","admin"]],["MASTER",[],"PUBLIC",[7,7,7]],true]];`

## Known Bugs
 - It is unknown if this is MP compatible. I am not able to test on a server with multiple people. If it does break in MP let me know and I will try to fix this. I do want this to work in MP.
 - Typing '<' in the terminal or in STEED will prevent any text after the `<` from being displayed unless followed by `br/>`. This is believed to be a limitation of the engine with the display method I am using. As such, you cannot type `<` in ArmaTerminal.
 - The text will truncate after a certain length is reached (over 2000 characters, possibly as far out as 5000). The text is still processed just not rendered. Pressing Control + X in the terminal, will wipe all previous lines so new text will be rendered for the time being.
 - Key modifiers (control and shift) sometimes don't register when pressed. This is an engine limitation. If I find a better solution, I will fix it, but just be persistent for now.

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