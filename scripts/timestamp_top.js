/*
Author: Robert Holland
Put backup timestamp at the top of the document.
*/

var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear=new Date();
var copyright = (copyrightyear.getFullYear());

var dashes = "// ------------------------------------------------------------";
dashes += "----------------\r\n";
  UltraEdit.activeDocument.top(); //Go to the top of the file.
  UltraEdit.activeDocument.write(dashes);
  UltraEdit.activeDocument.write("// Timestamp: " + myDate + "\r\n");
  UltraEdit.activeDocument.write(dashes);
