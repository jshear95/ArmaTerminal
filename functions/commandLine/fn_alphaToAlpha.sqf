/*
 *	Joshua Shear
 *	CommandLine_fnc_alphaToAlpha.sqf
 *	Takes in an input array and converts all lowercase letters to capital letters
 *	
 *	How to call : [_charArray] call CommandLine_fnc_alphaToAlpha;
 *	
 *	Returns : _charArray with all caps
 *	
 *	Function Calls:
 *		NONE
 */
 
private[_alpha];
_alpha = _this select 0;
if(typeName(_alpha) == "ARRAY")then{
	{
		switch(_x)do{
			case("q"):{"Q"};
			case("w"):{"W"};
			case("e"):{"E"};
			case("r"):{"R"};
			case("t"):{"T"};
			case("y"):{"Y"};
			case("u"):{"U"};
			case("i"):{"I"};
			case("o"):{"O"};
			case("p"):{"P"};
			case("a"):{"A"};
			case("s"):{"S"};
			case("d"):{"D"};
			case("f"):{"F"};
			case("g"):{"G"};
			case("h"):{"H"};
			case("j"):{"J"};
			case("k"):{"K"};
			case("l"):{"L"};
			case("z"):{"Z"};
			case("x"):{"X"};
			case("c"):{"C"};
			case("v"):{"V"};
			case("b"):{"B"};
			case("n"):{"N"};
			case("m"):{"M"};
		};
	}forEach _alpha;
}else{
	toUpper(_alpha);
};
_alpha;