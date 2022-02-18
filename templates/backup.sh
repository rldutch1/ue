for file in UETMPLTE.TPL.*
	do
		cat UETMPLTE.TPL > $file
		echo $file " updated."
	done