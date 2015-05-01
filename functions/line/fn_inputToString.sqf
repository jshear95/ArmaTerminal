/*
 * Takes in an array of input and returns the input as a string
 */
 
private[_input];

_input = _this select 0;

_output = "";

{
	_output = _output + _x;
}forEach _input;

_output;