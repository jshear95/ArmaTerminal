/**
	Pops all values from scrolledCommands (pull) and pushes them to prevCommands (push)
*/

private ["_pull","_push"];
_pull = _this select 0;
_push = _this select 1;

while{count _pull > 0}do{
	_val = count _pull - 1;

	_pull set [count _pull - 1 , "??" ];
	_pull = _pull - ["??"];

	_push set [count _push, _val];
};
[
	_pull,
	_push
];