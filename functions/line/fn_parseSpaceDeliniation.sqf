/*
 *	Joshua Shear
 *	Line_fnc_parseSpaceDeliniation.sqf
 *	Takes a string and returns the sub strings parsed for spaces minus spaces preceded by \ the escape char
 *	
 *	How to call : [string] call Line_fnc_parseSpaceDeliniation;
 *	
 *	Returns : Array of substrings parsed for spaces (\ is escape char)
 *	
 *	Function Calls :
 *		NONE
 */

private[_input,_output,_terminate,_spInd,_bsInd];
_input = _this select 0;
_input = _input + " ";
_output = [];

_index = 0;

while{_index < count _input}do{
	
	_spInd = _input select [_index, count _input - 1] find " ";
	_bsInd = _input select [_index, count _input - 1] find "\ ";
	//bs is for back slash not bull shit :)
	
	switch(true)do{
	
		//If there is a space in the 0 index
		case(_spInd == 0):{
			//Move Index over 1
			_index = _index + 1;
		};
		
		//If there are no more spaces
		case(_spInd == -1):{
			//set ind = the length of input to exit the while loop
			_output set[count _output, _input select [_index, count _input - 1]];
			_index = count _input;
		};
		
		//If you can find a space and its not preceded by a /
		case(_spInd != -1 && (_bsInd == -1 || _bsInd >  _spInd)):{
			//append to output the string from _index up until that space
			_output set[count _output, _input select [_index, _spInd]];
			//Set ind = the space after the space i.e. "abc efg" Ind = 4
			_index = _index + _spInd;
		};
		
		//If there is a space preceded by a \
		case(_spInd != -1 && _bsInd != -1 && _bsInd == _spInd - 1):{
			//Set index equal to the space after the space i.e. "abc\\ efg" Ind = 5
			_output set[count _output, (_input select [_index, _bsInd]) + " "];
			_index = (_index + _spInd + 1);
		};
	};
	
};

if(count _output > 1)then{
	_index = 0;
	while{_index < count _output - 1}do{
		if(" " == (_output select _index) select[(count(_output select _index)) - 1])then{
			_entry = _output select _index;
			_next = _output select _index + 1;
			
			_output set[_index, _entry + _next];
			_output set[_index + 1, ""];
			_output = _output - [""];
		}else{
			_index = _index + 1;
		};
	};
};

_output;