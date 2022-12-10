cd templates/
for file in UETMPLTE.TPL.*
	do
		cat UETMPLTE.TPL > $file
		echo $file " updated."
	done
cd ../
git commit -am "Adding modified files/templates."
