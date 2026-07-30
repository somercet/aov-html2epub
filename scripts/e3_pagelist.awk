
# page	master.html	page52	52
#        <li><a href="Text/part00e_introduction.xhtml#pagex">x</a></li>

BEGIN {
	print "  <section class=\"epub3pagelist\">"
	print "    <nav epub:type=\"page-list\" hidden=\"\">"
	print "      <h2>Page list</h2>"
	print "      <ol class=\"epub3pagelist_ol\">"
}

/^page/ {
	printf "        <li><a href=\"%s#%s\">%s</a></li>\n", $2, $3, $4
}

END {
	print "      </ol>"
	print "    </nav>"
	print "  </section>"
}
