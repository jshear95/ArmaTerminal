/*
 *	Joshua Shear
 *	Computer_fnc_print.sqf
 * 	Takes in a computer. Based on the state, the function prints it accordingly on screen.
 *	
 *	How to call : [_computer] call Computer_fnc_print;
 *	
 *	Returns : String of text printed (usually discarded/ignored by caller)
 *	
 *	Function Calls :
 *		NONE
 */
 
private [_comp,_state,_yOffset,_safe,_xCord,_yCord,_cmdLn,_prevLines,_curLine,_pText,_bool,_return,_header,_prevText,_postText];

_comp = _this select 0;
_state = _this select 0 select 4;
_yOffset = 0;
_safe = _this select 0 select 5 select 7;

if(_state == "COMMANDLINE")then{
	_yOffset = _this select 0 select 5 select 5;
};
if(_state == "EDITOR")then{
	_yOffset = _this select 0 select 7 select 4;
};

_xCord = 0*safeZoneW;
_yCord = 0*safeZoneH;


_printText = {											//print [_text] in the terminal
	private[_text,_txtColor,_displayText];
	
	_text = _this select 0;
	_txtColor = _comp select 6;
	_displayText = "";
	
	switch(_txtColor)do{
		case("#33CC33"):{	//Green
			_displayText = format ["<t size='0.4' color='#33CC33' align='left' font='EtelkaMonospacePro'>%1<br /></t>", _text];
		};
		case("#FFFFFF"):{	//White
			_displayText = format ["<t size='0.4' color='#FFFFFF' align='left' font='EtelkaMonospacePro'>%1<br /></t>", _text];
		};
	};
	
	null = [_displayText,_xCord,_yCord + _yOffset - (0.00051 * 11),0.09,0] spawn BIS_fnc_dynamicText;
	//null = [text,X,Y,Fade Out Time,Fade In Time] spawn BIS_fnc_dynamicText;
	
	_displayText;
};

switch (true) do {
	case (_state == "COMMANDLINE") : {
		//Gets text to print
		_cmdLn = _comp select 5;
		_prevLines = _cmdLn select 0;
		_curLine = _cmdLn select 1;
		
		//Compiles text to print
		_pText = "";
		{
			{
				_pText = _pText + _x;
			}forEach _x;
			_pText = _pText + "<br />";
		}forEach _prevLines;
		
		_bool = false;	//Weather the loop below has passed index 0
		{
			if(_safe&&_bool && str(_x) != str(""))then{
				_pText = _pText + "*";
			}else{
				_pText = _pText + _x;
				_bool = true;
			};
		}forEach _curLine;
		
		if(floor(time) mod 2 == 0)then{						//Toggles cursor at end of line every second
			_pText = _pText + "_";
		};
		
		_return = [_pText] call _printText;
	};
	case (_state == "EDITOR"):{
		//Gets text to print
		_header = _comp select 7 select 1;
		_prevText = _comp select 7 select 2;
		_postText = _comp select 7 select 3;
		
		_pText = _header;
		
		{
			_pText = _pText + _x;
		}forEach _prevText;
		
		if(floor(time) mod 2 == 0)then{						//Toggles cursor at cursor position every second
			if(str(_postText select 0) == str("<br/>"))then{//If the first char of post text is a line break, we don't want to replace the line break with a cursor
				_pText = _pText + "_";
				{
					_pText = _pText + _x;
				}forEach _postText;
			}else{
				_pText = _pText + "_";
				{
					_pText = _pText + _x;
				}forEach (_postText select[1, count _postText - 1]);
				//Gets all chars in post text except the first one which is replaced by the cursor char
			};
		}else{
			{
				_pText = _pText + _x;
			}forEach _postText;
		};
		
		_return = [_pText] call _printText;
	};
};