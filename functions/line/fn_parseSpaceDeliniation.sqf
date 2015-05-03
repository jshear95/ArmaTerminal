/*
 * Takes a string and returns the sub strings parsed for spaces minus spaces preceded by \ the escape char
 */

private[_input];
_input = _this select 0;
_input = _input + " ";
_output = [];

_index = 0;
_terminate = 20;
_log = "";


while{_index < count _input && _terminate > 0}do{
	
	_spInd = _input select [_index, count _input - 1] find " ";
	_bsInd = _input select [_index, count _input - 1] find "\ ";
	//bs is for back slash not bull shit :)
	
	switch(true)do{
	
		//If there is a space in the 0 index
		case(_spInd == 0):{
			_log = _log + "IND AT SPACE" + "\n";
			//Move Index over 1
			_index = _index + 1;
		};
		
		//If there are no more spaces
		case(_spInd == -1):{
			_log = _log + "NO MORE SPACES" + "\n";
			//set ind = the length of input to exit the while loop
			_output set[count _output, _input select [_index, count _input - 1]];
			_index = count _input;
		};
		
		//If you can find a space and its not preceded by a /
		case(_spInd != -1 && (_bsInd == -1 || _bsInd >  _spInd)):{
			_log = _log + "PARSABLE" + "\n";
			//append to output the string from _index up until that space
			_output set[count _output, _input select [_index, _spInd]];
			//Set ind = the space after the space i.e. "abc efg" Ind = 4
			_index = _index + _spInd;
		};
		case(_spInd != -1 && _bsInd != -1 && _bsInd == _spInd - 1):{
			_log = _log + "ESCAPE CHAR FOUND" + "\n";
			//Set ind = the space after the space i.e. "abc\\ efg" Ind = 4
			_output set[count _output, (_input select [_index, _bsInd]) + " "];
			_index = _index + _spInd;
		};
		
	};
	_log = _log + str(_input select [_index, count _input - 1]) + " | " + str(_spInd) + " | " + str(_index) + "\n";
	_terminate = _terminate - 1;
	
};
if(count _output > 1)then{
	_index = 0;
	while{_index < count _output - 1}do{
		if((_output select _index) find " " != -1)then{
			_log = _log + "CONCATENATING" + "\n";
			_entry = _output select _index;
			_next = _output select _index + 1;
			_output set[_index, _entry + _next];
			_output set[_index + 1, ""];
			_output = _output - [""];
		};
		_index = _index + 1;
	};
};

_log = _log + str(_output);
//hint _log;

_output;