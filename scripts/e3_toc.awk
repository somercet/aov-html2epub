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
	print indent(n) "</ol>\n" \
	      indent(n) "</li>"
}

BEGIN {
	FS = "	"

	vocab(etAbbr)
	etAbbr["text"] = "bodymatter"

	ind[0] = "      "
	prev = 0
	oltrack = 1

	print  ind[0] "<ol class=\"epub3toca\">"
	printf ind[0] "  <li><a epub:type=\"titlepage\" href=\"titlepage.xhtml\">Cover</a>"
}

/^[in]nav/ {
	if ( $5 )
		anchor = "#" $5
	else
		anchor = ""

	if ( $3 > prev )
		for ( i = prev; i < $3; )
			printf "\n%s<ol class=\"epub3toc%c epub3toc%d\">\n", \
				indent(i + 1), 97 + ++i, oltrack++
	else {
		print "</li>"
		if ( $3 < prev )
			for ( i = prev; i > $3; i-- )
				closer(i)
	}

	sub(/^([[:digit:]]+|[[:alpha:]][[:digit:]]*|[ivxlcdm]+|[IVXLCDM]+)\. +/, "", $6)

	printf "%s<li><a epub:type=\"%s\" href=\"%s\">%s</a>", \
		indent($3 + 1), etAbbr[$4], $2 anchor, $6
	prev = $3
}

END {
	print "</li>"
	for ( i = prev; i > 0; i-- )
		closer(i)
	print ind[0] "</ol>"
}

