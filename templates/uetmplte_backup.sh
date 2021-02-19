for file in UETMPLTE.TPL
	do
		cat $file > UETMPLTE.TPL.BAK
		cat $file > UETMPLTE.TPL.txt
	done