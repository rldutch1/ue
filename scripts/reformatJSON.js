// ----------------------------------------------------------------------------
// Script Author: Copied from http://www.ultraedit.com/files/scripts/reformatJSON.js by Robert Holland
// Script Name: reformatJSON.js
// Creation Date: Wed Aug 10 2016 14:18:08 GMT-0700 (US Mountain Standard Time)
// Last Modified:
// Copyright (c)2016
// Version: 1.0.0
// Purpose: Format JSON data so that it is easier to read.
// ----------------------------------------------------------------------------

if (!UltraEdit.columnMode) {
  if (!UltraEdit.activeDocument.isSel()) {
    UltraEdit.activeDocument.selectAll();
  }
  var jsonText = UltraEdit.activeDocument.selection;
  var json = JSON.parse(jsonText);
  var jsonTextFormatted = JSON.stringify(json, null, 2);
  UltraEdit.activeDocument.write(jsonTextFormatted);
}
