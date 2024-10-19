# ----------------------------------------------------------------------------
# Script Author: Robert Holland 
# Script Name: wbackup.ps1
# Creation Date: Fri Oct 18 2024 07:51:25 GMT-0700 (US Mountain Standard Time)
# Last Modified: 2024-10-18_07:51:58 
# Copyright (c)2024
# Purpose: Backup my UE Studio templates from Windows Powershell.
# ----------------------------------------------------------------------------

#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach?view=powershell-7.4
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4

#List all UETMPLTE.TPL.* files:
#get-childitem -path \Users\Rob\Downloads\Github\ue\templates\UETMPLTE.TPL.* -name
cd templates/
#Find the backup files to be updated:
foreach ($file in get-childitem -path \Users\Rob\Downloads\Github\ue\templates\UETMPLTE.TPL.* -name)
{
  #Write-Host 'This is a filename found: ' $file
  #Write the content of UETMPLTE.TPL to the backup files:
  type C:\Users\Rob\AppData\Roaming\IDMComp\UEStudio\templates\UETMPLTE.TPL > $file
}

 #Create a tar backup of the UETMPLTE.TPL* files:
tar -zcvf UETMPLTE_Backup.tar.gz C:\Users\Rob\AppData\Roaming\IDMComp\UEStudio\templates\UETMPLTE.TPL UETMPLTE.TPL.txt UETMPLTE.TPL.bak
cd ../

#Commit the updated files:
git commit -am "wbackup.ps1: Adding modified files/templates."


