//Create a new file, which will become the currently active document
//Write a header in the new active document
//Click on "Scripting" --> "Scripts" --> "Add"
//UltraEdit.newFile();
var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear = (myDate.getFullYear());

var dashes = "' ------------------------------------------------------------";
dashes += "----------------\r\n";
UltraEdit.activeDocument.top();
UltraEdit.activeDocument.write(dashes);
UltraEdit.activeDocument.write("' Script Author: Robert Holland \r\n");
UltraEdit.activeDocument.write("' Script Name: \r\n");
UltraEdit.activeDocument.write("' Creation Date: " + myDate + "\r\n");
UltraEdit.activeDocument.write("' Last Modified: \r\n");
UltraEdit.activeDocument.write("' Copyright (c)" + copyrightyear + "\r\n");
UltraEdit.activeDocument.write("' Purpose: \r\n");
UltraEdit.activeDocument.write(dashes + " \r\n");
