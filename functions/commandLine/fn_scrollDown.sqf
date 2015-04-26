/*
 * Pops previous command from the command stack and returns it.
 */

 private [_commandLine];
 
 _commandLine = _this select 0;
 
 _stack = _commandLine select 4;

_val = _stack select (count _stack - 1);

_stack set [count _stack - 1 , "" ];
_stack = _stack - [""];

_val;