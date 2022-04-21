/* Script Name:   SplitLargeFileByLineNumber.js
   Creation Date: 2016-11-04
   Last Modified: 2016-11-11
   Original:      http://www.ultraedit.com/files/scripts/SplitLargeFileByLineNumber.js
                  https://www.ultraedit.com/forums/viewtopic.php?f=52&t=12168
*/

// First file (most left on file tabs bar) must be the file to split.

if (UltraEdit.document.length > 0) {  // Is any file opened?

   // Set number of lines per block and number of blocks per file here!
   // Number of lines per file = nLinesPerBlock * nBlocksPerFile
   var nLinesPerBlock = 100000; //Change this number to the number of lines in each split file.
   var nBlocksPerFile = 5;
   var bCopyFirstLine = false;   // Copy first line into every file.

   var nNextLineNum = nLinesPerBlock + 1;
   var nFileCount = 0;

   // Define the environment for the script.
   UltraEdit.insertMode();
   UltraEdit.columnModeOff();
   UltraEdit.document[0].hexOff();
   // Move caret to top of the file.
   UltraEdit.document[0].top();

   if (bCopyFirstLine) {
      // Code to copy first line of file into user clipboard 8 for pasting
      // it later into every file created on splitting the large file.
      UltraEdit.selectClipboard(8);
      UltraEdit.document[0].selectLine();
      UltraEdit.document[0].copy();
      UltraEdit.document[0].cancelSelect();
      UltraEdit.document[0].gotoLine(2,1);
   }
   UltraEdit.selectClipboard(9);

   // Quick and dirty solution to get file name without extension
   // and the file extension. Does not work for all file names.
   var nLastPoint = UltraEdit.document[0].path.lastIndexOf('.');
   if (nLastPoint < 0) nLastPoint = UltraEdit.document[0].path.length;
   var sFileName = UltraEdit.document[0].path.substr(0,nLastPoint) + '_';
   var sFileExt = UltraEdit.document[0].path.substr(nLastPoint);

   while (1) {
      UltraEdit.document[0].gotoLineSelect(nNextLineNum,1);
      if (!UltraEdit.document[0].isSel()) break;

      // Copy the selected block to user clipboard 9.
      UltraEdit.document[0].copy();
      UltraEdit.document[0].cancelSelect();

      UltraEdit.newFile();

      // New files are always created with a temporary file independent on
      // what is selected in configuration for usage of temporary files as
      // a new file is not yet saved with a name in a specified directory.
      // This means also the undo feature is always enabled for new files.

      // Save the still empty new file with right name, close the file and
      // immediately open it again. If option "Open file without temp file
      // but NO Prompt" is selected at "Advanced - Configuration - File
      // Handling - Temporary Files" with a threshold value of 0, the new
      // file is opened now without usage of a temporary file which means
      // without Undo feature enabled for this file making it faster
      // copying and pasting large blocks into this new file.

      nFileCount++;
      var sFileNameWithPath = sFileName + nFileCount + sFileExt;
      UltraEdit.saveAs(sFileNameWithPath);
      UltraEdit.closeFile(UltraEdit.activeDocument.path,2);
      UltraEdit.open(sFileNameWithPath);

      if (bCopyFirstLine) {
         // Paste the first line first into the new file.
         UltraEdit.selectClipboard(8);
         UltraEdit.activeDocument.paste();
         UltraEdit.selectClipboard(9);
      }
      // Paste the file copied block into the new file.
      UltraEdit.activeDocument.paste();

      // Copy up to 4 more blocks from input file to current new file.
      // Each new file contains than 500.000 lines if input file has
      // enough lines remaining.
      for (var nBlock = 1; nBlock < nBlocksPerFile; nBlock++ )
      {
         nNextLineNum += nLinesPerBlock;
         UltraEdit.document[0].gotoLineSelect(nNextLineNum,1);
         if (!UltraEdit.document[0].isSel()) break;
         UltraEdit.document[0].copy();
         UltraEdit.document[0].cancelSelect();
         UltraEdit.activeDocument.paste();
      }

      // Close the file with saving although if empty file was really
      // opened without usage of a temporary file each paste was directly
      // written to storage media and therefore the file does not need
      // to be explicitly saved because everything is saved already.
      UltraEdit.closeFile(UltraEdit.activeDocument.path,1);
      nNextLineNum += nLinesPerBlock;
   }
   UltraEdit.document[0].top();

   // Clear the used user clipboards and reselect system clipboard.
   UltraEdit.clearClipboard();
   if (bCopyFirstLine) {
      UltraEdit.selectClipboard(8);
      UltraEdit.clearClipboard();
   }
   UltraEdit.selectClipboard(0);
   UltraEdit.messageBox(nFileCount + " files created.");
}