// Hello!  Welcome to the UltraEdit scripting environment.  Normally, you would
// put a header comment at the top of a javascript file to be used in UltraEdit
// in order to indicate the version of the UltraEdit scripting API, like so:
// Version = 1.00
// However, this is currently not necessary since the API will default to 1.00.

// ----------------------------------------------------------------------------
// header.js
// This script creates a header for all open documents
// Copyright (c)2007 IDM Computer Solutions, Inc.
// ----------------------------------------------------------------------------
// UltraEdit is our application object.  All UltraEdit operations will use this
// object.
// See UltraEdit Help for more details.

// Get the num of open documents.
//var num_of_docs = UltraEdit.document.length;

var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear=new Date();
var copyright = (copyrightyear.getFullYear());

var dashes = "REM ------------------------------------------------------------";
dashes += "----------------\r\n";

// Enumerate through all open documents and add the header.
//var index;
//for (index = 0; index < num_of_docs; index++) {
  UltraEdit.activeDocument.top();
  UltraEdit.activeDocument.write("@echo off \r\n");
  UltraEdit.activeDocument.write(dashes);
  UltraEdit.activeDocument.write("REM Author: Robert Holland \r\n");
  UltraEdit.activeDocument.write("REM Name: \r\n");
  UltraEdit.activeDocument.write("REM Creation Date: " + myDate + "\r\n");
	UltraEdit.activeDocument.write("REM Last Modified: \r\n");
	UltraEdit.activeDocument.write("REM Copyright (c)" + copyright + "\r\n");
  UltraEdit.activeDocument.write("REM Purpose: \r\n");
  UltraEdit.activeDocument.write(dashes);
//}

