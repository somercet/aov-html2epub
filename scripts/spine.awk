
#  <spine toc="toc.ncx">
#    <itemref idref="titlepage.xhtml" />
#  </spine>

#file    foo/bar/master.html     bar/master.html bar_master.html

BEGIN {
	print "  <spine toc=\"toc.ncx\">"
}

/^file/ {
	printf "    <itemref idref=\"%s\" />\n", $4
}

END {
	print "  </spine>"
}

