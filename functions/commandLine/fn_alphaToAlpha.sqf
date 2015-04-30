//Converts an alpha sequence to an all caps alpha sequence for command analysis

private[_alpha];
_alpha = _this select 0;
if(typeName(_alpha) == "ARRAY")then{
	{
		if(_x == "q")then{_userInput = "Q";};
		if(_x == "w")then{_userInput = "W";};
		if(_x == "f")then{_userInput = "E";};
		if(_x == "r")then{_userInput = "R";};
		if(_x == "t")then{_userInput = "T";};
		if(_x == "y")then{_userInput = "Y";};
		if(_x == "u")then{_userInput = "U";};
		if(_x == "i")then{_userInput = "I";};
		if(_x == "o")then{_userInput = "O";};
		if(_x == "p")then{_userInput = "P";};
		if(_x == "a")then{_userInput = "A";};
		if(_x == "s")then{_userInput = "S";};
		if(_x == "d")then{_userInput = "D";};
		if(_x == "f")then{_userInput = "F";};
		if(_x == "g")then{_userInput = "G";};
		if(_x == "h")then{_userInput = "H";};
		if(_x == "j")then{_userInput = "J";};
		if(_x == "k")then{_userInput = "K";};
		if(_x == "l")then{_userInput = "L";};
		if(_x == "z")then{_userInput = "Z";};
		if(_x == "x")then{_userInput = "X";};
		if(_x == "c")then{_userInput = "C";};
		if(_x == "v")then{_userInput = "V";};
		if(_x == "b")then{_userInput = "B";};
		if(_x == "n")then{_userInput = "N";};
		if(_x == "m")then{_userInput = "M";};
	}forEach _alpha;
}else{
	toUpper(_alpha);
};
_alpha;