//Create a new file, which will become the currently active document
//Write a header in the new active document
//Click on "Scripting" --> "Scripts" --> "Add"
UltraEdit.newFile();
var myDate=new Date();
var copyrightyear = (myDate.getFullYear());
var qq = (String.fromCharCode(34));
var dashes = "; ------------------------------------------------------------";
dashes += "----------------\r\n";
UltraEdit.activeDocument.write(dashes);
UltraEdit.activeDocument.write("; Script Author: Robert Holland \r\n");
UltraEdit.activeDocument.write("; Program Name: \r\n");
UltraEdit.activeDocument.write("; Creation Date: " + myDate + "\r\n");
UltraEdit.activeDocument.write("; Last Modified: \r\n");
UltraEdit.activeDocument.write("; Copyright (c)" + copyrightyear + "\r\n");
UltraEdit.activeDocument.write("; Purpose: \r\n");
UltraEdit.activeDocument.write("; Request #: \r\n");
UltraEdit.activeDocument.write(dashes + " \r\n");
UltraEdit.activeDocument.write("drop program 1bh_mpage_PROGRAMNAME:dba go" + "\r\n");
UltraEdit.activeDocument.write("create program 1bh_mpage_PROGRAMNAME:dba" + "\r\n");
UltraEdit.activeDocument.write("" + "\r\n");
UltraEdit.activeDocument.write("prompt" + "\r\n");
UltraEdit.activeDocument.write(""+ qq + "Output to File/Printer/MINE"+ qq + " = "+ qq + "MINE"+ qq + "   ;* Enter or select the printer or file name to send this report to." + "\r\n");
UltraEdit.activeDocument.write("	, "+ qq + "per_id"+ qq + " = 0" + "\r\n");
UltraEdit.activeDocument.write("	, "+ qq + "enc_id"+ qq + " = 0" + "\r\n");
UltraEdit.activeDocument.write("with OUTDEV, per_id, enc_id" + "\r\n");
