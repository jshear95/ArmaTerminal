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

private _comp = _this select 0;
private _state = _this select 0 select 4;
private _safe = _this select 0 select 5 select 6;


_printText = {											//print [_text] in the terminal
	private _text = _this select 0;
	private _txtColor = _comp select 6;
	_foo = ctrlSetText [101, _text];
};

switch (true) do {
	case (_state == "COMMANDLINE") : {
		//Gets text to print
		private _cmdLn = _comp select 5;
		private _prevLines = _cmdLn select 0;
		private _curLine = _cmdLn select 1;
		
		//Compiles text to print
		private _pText = "";
		{
			{
				_pText = _pText + _x;
			}forEach _x;
			_pText = _pText + "\n";
		}forEach _prevLines;
		
		private _bool = false;	//Weather the loop below has passed index 0
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
		
		[_pText] call _printText;
	};
	case (_state == "EDITOR"):{
		//Gets text to print
		private _header = _comp select 7 select 1;
		private _prevText = _comp select 7 select 2;
		private _postText = _comp select 7 select 3;
		
		_pText = _header;
		
		{
			_pText = _pText + _x;
		}forEach _prevText;
		
		if(floor(time) mod 2 == 0)then{						//Toggles cursor at cursor position every second
			switch (true) do {
				case (str(_postText select 0) == str("\n")) : {
					_pText = _pText + "_";
					{
						_pText = _pText + _x;
					}forEach _postText;
				};
				case (str(_postText select 0) == str("    ")) : {
					_pText = _pText + "_   ";
					{
						_pText = _pText + _x;
					}forEach (_postText select[1, count _postText - 1]);
				};
				case (true) : {
					_pText = _pText + "_";
					{
						_pText = _pText + _x;
					}forEach (_postText select[1, count _postText - 1]);
					//Gets all chars in post text except the first one which is replaced by the cursor char
				};
			};
		}else{
			{
				_pText = _pText + _x;
			}forEach _postText;
		};
		
		[_pText] call _printText;
	};
};