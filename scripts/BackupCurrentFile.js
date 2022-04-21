// Make a time-stamped copy of the current document, saved to the same directory.
// Backup file names are of the form filename.extension.yyyymmdd-hhmmss,
// e.g. backup backupSingleFile.js to backupSingleFile.js.2010023-174610.bak.

// Created by Robert Mark Bram, 23/01/2010 5:48:38 PM
// Thanks Mofi for telling me how to fix it up.

// Modified by: Robert Holland
// Modified Date: Thu Sep 19 2013 22:33:51 GMT-0700 (US Mountain Standard Time)
// Modification: Added the ability to insert a leading zero if the date, hour, minute, or second is less than 10.
// Original filename and location: http://www.ultraedit.com/files/scripts/backupSingleFile.js
// New filename: backupSingleFileNew.js
// Example backup filename: backupSingleFileNew.js.20130819-070800.bak.

// Determine the document index of the active document.
var nActiveDocIndex = 0;
while (nActiveDocIndex < UltraEdit.document.length) {
   if (UltraEdit.activeDocument.path == UltraEdit.document[nActiveDocIndex].path) break;
   nActiveDocIndex++;
}
// Copy file contents and reset cursor back to where it was.
var x = UltraEdit.activeDocument.currentLineNum;
var y = UltraEdit.activeDocument.currentColumnNum;
UltraEdit.activeDocument.selectAll();
UltraEdit.activeDocument.copy();
UltraEdit.activeDocument.gotoLine(x, y+1);

// Copy contents into the backup file, save and close it.
var FullFileName = UltraEdit.activeDocument.path;
UltraEdit.newFile();
UltraEdit.activeDocument.paste();
var now = new Date();

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

UltraEdit.saveAs(FullFileName
      + "."
      + now.getFullYear()
      + month
      + day
//      + "-"
      + hours
      + minutes
      + seconds
      + "RH.bak");
UltraEdit.closeFile(UltraEdit.activeDocument.path,2);

// Go back to the document whose contents we copied.
UltraEdit.document[nActiveDocIndex].setActive();
