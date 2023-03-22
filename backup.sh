cd templates/
for file in UETMPLTE.TPL.*
	do
		cat UETMPLTE.TPL > $file
		echo $file " updated."
	done
	tar -zcvf UETMPLTE_Backup.tar.gz UETMPLTE.TPL UETMPLTE.txt UETMPLTE.bak
cd ../
git commit -am "Adding modified files/templates."
