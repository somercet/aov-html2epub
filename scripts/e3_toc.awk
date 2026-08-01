#nnav	master.html	1	type	sec3	Title

@include "fr_vocab.awk"

function indent(n) {
	if (! ind[n] ) {
		ind[n] = ind[0]
		for ( i = 0; i < n; i++ )
			ind[n] = ind[n] "  "
	}
	return ind[n]
}

function closer(n) {
	printf "</li>\n%s</ol>", indent(n)
}

BEGIN {
	FS = "	"

	vocab_all(etAbbr)
	etAbbr["text"] = "bodymatter"

	ind[0] = "      "
	prev = 0
	oltrack = 1

	print "  <section class=\"epub3toc\" epub:type=\"toc\">"
	print "    <header>"
	print "      <h2>Contents</h2>"
	print "    </header>"
	print "    <nav epub:type=\"toc\" id=\"toc\">"
	print "    <ol class=\"epub3toca\">"
	printf ind[0] "<li><a epub:type=\"titlepage\" href=\"titlepage.xhtml\">Cover</a></li>\n"
	printf ind[0] "<li><a epub:type=\"toc\" href=\"toc.xhtml\">Table of Contents</a>"
}

/^[in]nav/ {
	if ( $5 )
		anchor = "#" $5
	else
		anchor = ""

	if ( $3 == prev )
		printf "</li>\n%s<li>", indent($3)
	else if ( $3 > prev )
		for ( i = prev; $3 > i; i++ )
			printf "\n%s<ol class=\"epub3toc%c epub3toc%d\">\n%s  <li>", \
				indent(i), 98 + i, oltrack++, indent(i)
	else {
		for ( i = prev; $3 < i; )
			closer(--i)
		printf "</li>\n" indent($3) "<li>"
	}

	sub(/^([[:digit:]]+|[[:alpha:]][[:digit:]]*|[ivxlcdm]+|[IVXLCDM]+)\. +/, "", $6)

	if ( $4 )
		etype = " epub:type=\"" etAbbr[$4] "\""
	else
		etype = ""
	printf "<a%s href=\"%s\">%s</a>", \
		etype, $2 anchor, $6
	prev = $3
}

END {
	for ( i = prev; i > 0; )
		closer(--i)
	print "</li>\n    </ol>"
#	print "      </ol>"
	print "    </nav>"
	print "  </section>"
}

