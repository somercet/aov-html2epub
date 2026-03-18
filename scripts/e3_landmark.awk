
BEGIN {
	FS = "	"

	print "  <section class=\"epub3landmarks\">"
	print "    <nav epub:type=\"landmarks\" hidden=\"hidden\">"
	print "      <h2>Guide</h2>"
	print "      <ol>"
	entry = "        <li><a epub:type=\"%s\" href=\"%s\">%s</a></li>\n"
	printf entry, "toc", "#toc", "Table of Contents"
}

$4 ~ /^text$/ {
	if ($5)
		anchor = "#" $5
	else
		anchor = ""

	printf entry, "bodymatter", $2 anchor, "Start of Content"
}

END {
	print "      </ol>"
	print "    </nav>"
	print "  </section>"
}

# "loi", "content.html#loi", "List of Illustrations"
