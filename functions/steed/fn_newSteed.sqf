/*
 *	Takes in a file name and char array
 *	Returns a textEditor (STEED)
 */

private[_fileName, _fileContents];

_fileName = _this select 0;
_fileContents = _this select 1;
_header = _fileName + "<br/>Control+Z to exit without saving<br/>Control+S to save and exit<br/>";
_prevText = [""];
_postText = _fileContents;
_yOffset = 0;
/*UnImplemented Variables
_highlightText = [""];
_clipboard = [""];
_updateName = _fileName;
_footer = "";
_cursorPos = True;
*/

_steed = [_fileName, _header, _prevText, _postText, _yOffset];
_steed
