/*
 * Takes in a computer. Based on the state, the function prints it accordingly on screen.
 */
 
private [_comp];

_comp = _this select 0;
_state = _this select 0 select 4;
_yOffset = _this select 0 select 5 select 5;

_xCord = 0*safeZoneW;
_yCord = 0*safeZoneH;


_printText = {											//print [_text] in the terminal
	private[_text];
	_text = _this select 0;
	_txtColor = "#33CC33";
	_displayText = "";
	if(_txtColor == "#33CC33")then{
		_displayText = format ["<t size='0.55' color='#33CC33' align='left'>%1<br /></t>", _text];
	}else{
		_displayText = format ["<t size='0.55' color='#FFFFFF' align='left'>%1<br /></t>", _text];
	};
	null = [_displayText,_xCord,_yCord + _yOffset,0.09,0] spawn BIS_fnc_dynamicText;
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
		{
			_pText = _pText + _x;
		}forEach _curLine;
		if(floor(time) mod 2 == 0)then{						//Toggles cursor at end of line every second
			_pText = _pText + "_";
		};
		_return = [_pText] call _printText;
	};
};