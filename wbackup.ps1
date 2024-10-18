# ----------------------------------------------------------------------------
# Script Author: Robert Holland 
# Script Name: wbackup.ps1
# Creation Date: Fri Oct 18 2024 07:51:25 GMT-0700 (US Mountain Standard Time)
# Last Modified: 2024-10-18_07:51:58 
# Copyright (c)2024
# Purpose: Backup my UE Studiow templates.
# ----------------------------------------------------------------------------

#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach?view=powershell-7.4
#https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-7.4

#List all UETMPLTE.TPL.* files:
#get-childitem -path \Users\Rob\Downloads\Github\ue\templates\UETMPLTE.TPL.* -name
cd templates/
foreach ($file in get-childitem -path \Users\Rob\Downloads\Github\ue\templates\UETMPLTE.TPL.* -name)
{
  #Write-Host 'This is a filename found: ' $file
  type C:\Users\Rob\AppData\Roaming\IDMComp\UEStudio\templates\UETMPLTE.TPL > $file
}

tar -zcvf UETMPLTE_Backup.tar.gz C:\Users\Rob\AppData\Roaming\IDMComp\UEStudio\templates\UETMPLTE.TPL UETMPLTE.TPL.txt UETMPLTE.TPL.bak
cd ../
git commit -am "wbackup.ps1: Adding modified files/templates."

#Below is my bash shell script named backup.sh.
#cd templates/
#for file in UETMPLTE.TPL.*
#	do
#		#cat UETMPLTE.TPL > $file
#		cat /mnt/c/Users/rob/AppData/Roaming/IDComp/UEStudio/templates/UETMPLTE.TPL > $file
#		echo $file " updated."
#	done
#	tar -zcvf UETMPLTE_Backup.tar.gz UETMPLTE.TPL UETMPLTE.TPL.txt UETMPLTE.TPL.bak
#cd ../
##git commit -am "Adding modified files/templates."
