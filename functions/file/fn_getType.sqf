/*
 *	Takes in a file and returns a boolean weather or not the file is a directory or not
 */
 
private[_file];
_file = _this select 0;
_bool = false;
if(count (_file select 1) > 0)then{
	if(typeName(_file select 1 select 0) == "ARRAY" || str(_file select 1) == str([]))then{
		_bool = true;
	};
}else{
	_bool = true;
};

_bool;