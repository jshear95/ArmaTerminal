/*
 * Takes in a file and returns the name of the file (way more complicated than it sounds)
 */

 private[_thing];
 _thing = _this select 0;
 _name = [_thing select 0] call CommandLine_fnc_alphaToAlpha;
 _name;