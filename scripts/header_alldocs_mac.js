// Hello welcome to the UltraEdit scripting environment. Normally you would
// put a header comment at the top of a javascript file to be used in UltraEdit
// in order to indicate the version of the UltraEdit scripting API like so:
// Version = 1.00
// However, this is currently not necessary since the API will default to 1.00.

// ----------------------------------------------------------------------------
// header.js
// This script creates a header for all open documents
// ----------------------------------------------------------------------------
// UltraEdit is our application object. All UltraEdit operations will use this
// object.

// Get the num of open documents.
var num_of_docs = UltraEdit.document.length;

var dashes = "// ------------------------------------------------------------";
dashes += "----------------\r\n";

//Get timestamp
var now = new Date();
var longdate = new Date();
longdate.setDate(longdate.getDate());
var month = (now.getMonth());
month = month + 1; //Adding one to Month. Month is zero based. Example: September shows as 8 instead of 9.
  if (month < 10) {
     month = "0" + month
  }

var day = (now.getDate());
  if (day < 10) {
     day = "0" + day
  }

var hours = (now.getHours());
  if (hours < 10) {
     hours = "0" + hours
  }

var minutes = (now.getMinutes());
  if (minutes < 10) {
     minutes = "0" + minutes
  }

var seconds = (now.getSeconds());
  if (seconds < 10) {
     seconds = "0" + seconds
  }

//UltraEdit.saveAs(FullFileName
//      + "."
//      + now.getFullYear()
//      + month
//      + day
//      + "-"
//      + hours
//      + minutes
//      + seconds
//      + "RH.bak");

// Enumerate through all open documents and add the header.
var index;
for (index = 0; index < num_of_docs; index++) {
  UltraEdit.document[index].top();
  UltraEdit.document[index].write(dashes);
  UltraEdit.document[index].write("// Script Author: Robert Holland \r\n");
  UltraEdit.document[index].write("// Script Name: \r\n");
  UltraEdit.document[index].write("// Creation Date: " + longdate +"\r\n");
  UltraEdit.document[index].write("// Last Modified: \r\n");
  UltraEdit.document[index].write("// Copyright (c) " + now.getFullYear() + "\r\n");
  UltraEdit.document[index].write("// Purpose: \r\n");
  UltraEdit.document[index].write(dashes);
} //end for loop