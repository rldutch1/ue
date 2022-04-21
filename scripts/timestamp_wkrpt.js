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

var lastWeek = (now.getFullYear(), now.getMonth(), now.getDate() - 6);
//  if (day < 10) {
//     day = "0" + day
//  }

//var lastWeekDisplay = lastWeekMonth + "/" + lastWeekDay + "/" + lastWeekYear;

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

//Write the full military time to the document. Format is: YearMonthDayHourMinuteSecond.
//UltraEdit.activeDocument.write(
//			"\r\nSubject: "
//			+ day + "/"
//      + month+ "/"
//      + now.getFullYear()
//      + " Weekly Report - Robert Holland \r\n"
//
//			+ "Tab Name: "
//			+ lastWeek + "/"
//      + month+ "/"
//      + now.getFullYear()
//			+ " - "
//			+ day + "/"
//      + month+ "/"
//      + now.getFullYear()
//      + " Weekly Report \r\n"
//
////			+ "Friday "
//			+ "Week: "
//			+ lastWeek + "/"
//      + month+ "/"
//      + now.getFullYear()
////      + " - Thursday "
//			+ " - "
//			+ day + "/"
//      + month+ "/"
//      + now.getFullYear()
//      + " \r\n"
//      + "\r\nTake a look at the time calculations in I:\\Winintel\\Static_Content\\custom_mpage_content\\mpages\\verge\\js\\verge.js \r\n");


  var StartDT = new Date();
  var lastWeek = new Date(StartDT.getTime() - 10080 * 60000);//Subtract 10080 minutes (1 week)
  var lastWeek = lastWeek.toString();
  var today = new Date(StartDT.getTime() + 0 * 60000);//
  var today = today.toString();
  //console.log("Week: " + lastWeek.substring(0, 16) + " - " + today.substring(0, 16));
UltraEdit.activeDocument.write(
  "Week: " + lastWeek.substring(0, 16) + " - " + today.substring(0, 16) + "\r\n"
  );
