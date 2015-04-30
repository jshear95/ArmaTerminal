/*
 * Takes in a file and returns the name of the file (way more complicated than it sounds)
 */

 private[_file];
 _file = _this select 0;
 _name = [_file select 0] call CommandLine_fnc_alphaToAlpha;
 _name;