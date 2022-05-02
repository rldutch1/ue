//Create a new file, which will become the currently active document
//Write a header in the new active document
//Click on "Scripting" --> "Scripts" --> "Add"
//UltraEdit.newFile();
var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear = (myDate.getFullYear());

var dashes = "/***********************************************************************";
dashes += "****************\r\n";
UltraEdit.activeDocument.top();
UltraEdit.activeDocument.write(dashes);
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("Report Name:  \r\n");
UltraEdit.activeDocument.write("Program Name: 1bh_\r\n");
UltraEdit.activeDocument.write("Initial Release Date: " + myDate + "\r\n");
UltraEdit.activeDocument.write("Author: \r\n");
UltraEdit.activeDocument.write("Requester: \r\n");
UltraEdit.activeDocument.write("Copyright (c)" + copyrightyear + "\r\n");
UltraEdit.activeDocument.write("Reference: \r\n");
UltraEdit.activeDocument.write("Usage: execute xxxxxx \"MINE\" 0000000.00, 000000.00 go \r\n");
UltraEdit.activeDocument.write("Purpose and Description: \r\n");
UltraEdit.activeDocument.write("*********************************************************************************\r\n");
UltraEdit.activeDocument.write("**                   CHANGE MODIFICATION LOG                                   **\r\n");
UltraEdit.activeDocument.write("*********************************************************************************\r\n");
UltraEdit.activeDocument.write("Mod             Date            Programmer        SN Ticket       Comment\r\n");
UltraEdit.activeDocument.write("------          ----------      -----------       -------------   ---------------\r\n");
UltraEdit.activeDocument.write("001             mm/dd/yyyy      yourname          RITM and CHG    Initial Release\r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("********************************************************************************/\r\n");
//UltraEdit.activeDocument.write(dashes + " \r\n");
