//Create a new file, which will become the currently active document
//Write a header in the new active document

UltraEdit.newFile();
var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear=new Date();
var copyright = (copyrightyear.getFullYear());

var dashes = "REM ------------------------------------------------------------";
dashes += "----------------\r\n";
  UltraEdit.activeDocument.write("@echo off \r\n");
  UltraEdit.activeDocument.write(dashes);
  UltraEdit.activeDocument.write("REM Author: Robert Holland \r\n");
  UltraEdit.activeDocument.write("REM Name: \r\n");
  UltraEdit.activeDocument.write("REM Creation Date: " + myDate + "\r\n");
	UltraEdit.activeDocument.write("REM Last Modified: \r\n");
	UltraEdit.activeDocument.write("REM Copyright (c)" + copyright + "\r\n");
  UltraEdit.activeDocument.write("REM Purpose: \r\n");
UltraEdit.activeDocument.write(dashes);

/*
// Enumerate through all open documents and add the header.
var index;
for (index = 0; index < num_of_docs; index++) {
  UltraEdit.activeDocument.top();
  UltraEdit.activeDocument.write(dashes);
  UltraEdit.activeDocument.write("// Script Author: \r\n");
  UltraEdit.activeDocument.write("// Script Name: \r\n");
  UltraEdit.activeDocument.write("// Creation Date: \r\n");
  UltraEdit.activeDocument.write("// Last Modified: \r\n");
  UltraEdit.activeDocument.write("// Copyright (c)2010\r\n");
  UltraEdit.activeDocument.write("// Purpose: \r\n");
  UltraEdit.activeDocument.write(dashes);
} //end for loop
*/