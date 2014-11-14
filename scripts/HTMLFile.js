//Create a new file, which will become the currently active document
//Write a header in the new active document
//Click on "Scripting" --> "Scripts" --> "Add"
UltraEdit.newFile();
var myDate=new Date();
myDate.setDate(myDate.getDate());
var copyrightyear=new Date();
var copyright = (copyrightyear.getFullYear());
UltraEdit.activeDocument.write("<!-- Created " + myDate + " --> \r\n");
UltraEdit.activeDocument.write("<html> \r\n");
UltraEdit.activeDocument.write("<head></head> \r\n");
UltraEdit.activeDocument.write("<title></title> \r\n");
UltraEdit.activeDocument.write("<body> \r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("<p>Blank</p> \r\n");
UltraEdit.activeDocument.write("\r\n");
UltraEdit.activeDocument.write("</body> \r\n");
UltraEdit.activeDocument.write("</html> \r\n");
