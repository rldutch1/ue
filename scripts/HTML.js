//Create a new HTML file which will become the currently active document

UltraEdit.newFile();
var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear=new Date();
var copyright = (copyrightyear.getFullYear());

UltraEdit.activeDocument.write("<!-- \r\n");
UltraEdit.activeDocument.write("Script Author: Robert Holland \r\n");
UltraEdit.activeDocument.write("Script Name: \r\n");
UltraEdit.activeDocument.write("Creation Date: " + myDate + "\r\n");
UltraEdit.activeDocument.write("Last Modified: \r\n");
UltraEdit.activeDocument.write("Copyright (c)" + copyright + "\r\n");
UltraEdit.activeDocument.write("Purpose: \r\n");
UltraEdit.activeDocument.write("--> \r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("<html> \r\n");
UltraEdit.activeDocument.write("<title></title> \r\n");
UltraEdit.activeDocument.write("<head></head> \r\n");
UltraEdit.activeDocument.write("<body> \r\n  \r\n");
UltraEdit.activeDocument.write("<p> Blank </p> \r\n  \r\n");
UltraEdit.activeDocument.write("</body> \r\n");
UltraEdit.activeDocument.write("</html> \r\n");


/*
//Create a new file, which will become the currently active document
//Write a header in the new active document

UltraEdit.newFile();
var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear=new Date();
var copyright = (copyrightyear.getFullYear());

var dashes = "// ------------------------------------------------------------";
dashes += "----------------\r\n";
UltraEdit.activeDocument.write(dashes);
UltraEdit.activeDocument.write("// Script Author: Robert Holland \r\n");
UltraEdit.activeDocument.write("// Script Name: \r\n");
UltraEdit.activeDocument.write("// Creation Date: " + myDate + "\r\n");
UltraEdit.activeDocument.write("// Last Modified: \r\n");
UltraEdit.activeDocument.write("// Copyright (c)" + copyright + "\r\n");
UltraEdit.activeDocument.write("// Purpose: \r\n");
UltraEdit.activeDocument.write(dashes);

*/