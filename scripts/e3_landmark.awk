
@include "fr_vocab.awk"

BEGIN {
	FS = "	"
	vocab_long(etLong)
	vocab_landm(etAbbr)
	etAbbr["text"] = "bodymatter"
	entry = "        <li><a epub:type=\"%s\" href=\"%s\">%s</a></li>\n"

	print "  <section class=\"epub3landmarks\">"
	print "    <nav epub:type=\"landmarks\" hidden=\"hidden\">"
	print "      <h2>Guide</h2>"
	print "      <ol>"
}

/^(nnav|lloi|llot|ttoc)/ && etAbbr[$4] {
	if ($5)
		anchor = "#" $5
	else
		anchor = ""

	printf entry, etAbbr[$4], $2 anchor, etLong[$4]

	next
}

END {
	print "      </ol>"
	print "    </nav>"
	print "  </section>"
}

# "loi", "content.html#loi", "List of Illustrations"
