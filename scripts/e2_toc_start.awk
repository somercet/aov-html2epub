
BEGIN {
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	print "<ncx xmlns=\"http://www.daisy.org/z3986/2005/ncx/\" version=\"2005-1\" xml:lang=\"" elang "\">"
	print "  <head>"
	print "    <meta name=\"dtb:ui\" content=\"" uuid "\" />"
}

/^dtbdep/ {
	print "    <meta name=\"dtb:depth\" content=\"" $2 "\" />"
}

/^dtbPC/ {
	print "    <meta name=\"dtb:totalPageCount\" content=\"" $2 "\" />"
}

/^dtblast/ {
	print "    <meta name=\"dtb:maxPageNumber\" content=\"" $2 "\" />"
}

END {
	print "    <meta name=\"dtb:generator\" content=\"aov-html2epub\" />"
	print "  </head>"
	print "  <docTitle>"
	print "    <text>" title "</text>"
	print "  </docTitle>"

	if ( authormunge ) {
		print "  <docAuthor>"
		print "    <text>" authormunge "</text>"
		print "  </docAuthor>"
	}
}


