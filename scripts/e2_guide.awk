
#<guide> add to OPF

@include "fr_vocab.awk"

BEGIN {
	c = 0
	FS = "	"
	vocab_landm(etAbbr)
	vocab_long(etLong)
	format = "  <reference type=\"%s\" href=\"%s\" title=\"%s\" />\n"
}

/^(nnav|lloi|llot|ttoc)/ && etAbbr[$4] {
	if (! c)
		print "<guide>"
	c++

	if ($5)
		anchor = "#" $5
	else
		anchor = ""

	printf format, etAbbr[$4], $2 anchor, etLong[$4]
}

END {
	if (c)
		print "</guide>"
}

# "loi", "content.html#loi", "List of Illustrations"

