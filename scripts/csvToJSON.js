// ----------------------------------------------------------------------------
// Script Author: Robert Holland
// Script Name: csvToJSON.js
// Creation Date: Sat Jun 03 2023 10:26:02 GMT-0700 (US Mountain Standard Time)
// Source: https://www.youtube.com/watch?v=AOV-MSW4CsE
// Copyright (c)2023
// Version: 1.0.0
// Purpose: UE script to convert CSV data to JSON data. Modified to put JSON data in a new window.
// ----------------------------------------------------------------------------

// @Engine=WebView2
var csv_data = UltraEdit.activeDocument.selection;
var converted_data = csvToJSON(csv_data);

UltraEdit.outputWindow.showWindow(true);
UltraEdit.outputWindow.write(converted_data);
UltraEdit.newFile();
UltraEdit.activeDocument.write(converted_data);

function csvToJSON(csvData){
	const lines = csvData.trim().split('\n');
	const headers = lines[0].split(',');
	const jsonData = [];

	for (i = 1; i < lines.length; i++){
	const currentLine = lines[i].split(',');
	const jsonRow = {};

	for (j = 0; j < headers.length; j++){
		jsonRow[headers[j]] = currentLine[j];
	}
		jsonData.push(jsonRow);
	}
		return JSON.stringify(jsonData);
}
