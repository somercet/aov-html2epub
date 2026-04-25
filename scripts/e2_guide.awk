
#<guide> add to OPF

@include "fr_vocab.awk"

BEGIN {
	FS = "	"
	vocab_landm(etAbbr)
	vocab_long(etLong)
	format = "  <reference type=\"%s\" href=\"%s\" title=\"%s\" />\n"

	print "<guide>"
}

/^(nnav|lloi|llot|ttoc)/ && etAbbr[$4] {
	if ($5)
		anchor = "#" $5
	else
		anchor = ""

	printf format, etAbbr[$4], $2 anchor, etLong[$4]
}

END { 
	print "</guide>"
}

# "loi", "content.html#loi", "List of Illustrations"

