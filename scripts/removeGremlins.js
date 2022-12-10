// ----------------------------------------------------------------------------
// Script Name:removeGremlins(NonPrintableChars).js
// Creation Date: 2012-09-19
// Last Modified:
// Purpose: Removes non printable characters (known as "gremlins") from file.
//          If a selection exists prior to the script being played, then it will
//          remove non-printable characters from the selection (no reporting).
// ----------------------------------------------------------------------------

// set Find/Replace properties
UltraEdit.perlReOn();
UltraEdit.activeDocument.findReplace.mode=0;
UltraEdit.activeDocument.findReplace.matchCase=false;
UltraEdit.activeDocument.findReplace.matchWord=false;
UltraEdit.activeDocument.findReplace.regExp=true;
UltraEdit.activeDocument.findReplace.searchDown=true;
UltraEdit.activeDocument.findReplace.searchInColumn=false;
UltraEdit.activeDocument.findReplace.preserveCase=false;
UltraEdit.activeDocument.findReplace.replaceAll=false;
UltraEdit.activeDocument.findReplace.replaceInAllOpen=false;
UltraEdit.activeDocument.findReplace.selectText = false;

// show output window
UltraEdit.outputWindow.clear();
UltraEdit.outputWindow.showOutput=true;
UltraEdit.outputWindow.showWindow(true);

// define non-printable characters
var nonpr = '[\\x00-\\x08\\x0B\\x0C\\x0E\\x0F\\x10-\\x1F\\x7F]';

// get line/col to return to
var pos = UltraEdit.activeDocument.currentPos;
var inSel = false;
var repType = "this file";

// check if selection exists
if (UltraEdit.activeDocument.selection.length > 0) {
  UltraEdit.activeDocument.findReplace.mode = 1;
  UltraEdit.activeDocument.findReplace.replaceAll=true;
  var inSel = true;
  var repType = "selection";
}

// go to top
if (!inSel) UltraEdit.activeDocument.top();

// ask user what character to replace "gremlins" with?
var repchar = UltraEdit.getString("What character(s) should I replace \"Gremlins\" (non-printable characters) with?",1);

// path
var fpath = UltraEdit.activeDocument.path;

var i = 0; // count total replacements

// Loop through the file, count and delete found lines
if (!inSel) {
  UltraEdit.activeDocument.findReplace.find(nonpr);
  while (UltraEdit.activeDocument.isFound()) {
    if (UltraEdit.activeDocument.isFound()) {
      if (i < 1) UltraEdit.outputWindow.write("Gremlins found (double-click to jump to location):");
      UltraEdit.activeDocument.findReplace.find(nonpr);
      var gln = UltraEdit.activeDocument.currentLineNum;
      var gcol = UltraEdit.activeDocument.currentColumnNum;
      gcol = parseInt(gcol) - 2;
      gcol = gcol.toString();
      UltraEdit.outputWindow.write(fpath + "/" + gln + "/" + gcol);
      UltraEdit.activeDocument.top();
      UltraEdit.activeDocument.findReplace.replace(nonpr, repchar);
      i++;
    }
    //Find the next instance.
    UltraEdit.activeDocument.top();
    UltraEdit.activeDocument.findReplace.find(nonpr);
    UltraEdit.activeDocument.top();
  }
  //Write the final status.
  if (i == 0) {
    UltraEdit.outputWindow.write("No gremlins found. No data was changed.");
  } else if (i == 1) {
    UltraEdit.outputWindow.write("_________________________________________");
    UltraEdit.outputWindow.write(i + " gremlin was found and removed from " + repType + ".");
  } else {
    UltraEdit.outputWindow.write("_________________________________________");
    UltraEdit.outputWindow.write(i + " gremlins were found and removed from " + repType + ".");
  }
  // return to original location
  UltraEdit.activeDocument.gotoPos(pos);
} else {
  // Do replace in selection only.
  UltraEdit.activeDocument.findReplace.replace(nonpr, repchar);
  UltraEdit.outputWindow.write("All gremlins removed from " + repType + ".");
}
