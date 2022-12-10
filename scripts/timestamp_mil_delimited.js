//Get current datetime.
var now = new Date();

//Assign time parts.
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

var year = now.getFullYear();
//Write the full military time to the document. Format is: YearMonthDayHourMinuteSecond.
UltraEdit.activeDocument.write(
				year +"-"
      + month +"-"
      + day +""
      + "_"
      + hours +":"
      + minutes +":"
      + seconds+ " ");
