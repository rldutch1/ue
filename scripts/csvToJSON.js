
var csv_data = UltraEdit.activeDocument.selection;
var converted_data = csvToJSON(csv_data);

UltraEdit.outputWindow.showWindow(true);
UltraEdit.outputWindow.write(converted_data);
//UltraEdit.activeDocument.write(converted_data);

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
