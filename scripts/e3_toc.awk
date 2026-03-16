#nnav	master.html	1	type	sec3	Title

@include "fr_vocab.awk"

BEGIN {
	FS = "	"

	vocab(etAbbr)
	etAbbr["text"] = "bodymatter"

	prev = 0
	first = 1
	oltrack = 1

	print "      <ol class=\"epub3toca\">"
	print "        <li><a epub:type=\"titlepage\" href=\"titlepage.xhtml\">Cover</a></li>"
}

function indent(n,  s,i) {
	s=""
	for ( i=0; i<n; i++ ) s=s"  "
	return s
}

/^[in]nav/ {
	level=$3
	text=$5

	if (! first )
		if ( level > prev )
			for ( i = prev; i < level; i++ )
				printf "\n%s      <ol class=\"epub3toc%c epub3toc%d\">\n", \
					indent(i+1), 97 + $3, oltrack++
		else if ( level < prev )
			for ( i = prev; i > level; i-- ) {
				print "</li>"
				print indent(i) "      </ol>"
			}
		else
			print "</lii>"
	else first=0

	if ( $5 )
		anchor = "#" $5
	else
		anchor = ""
	printf "%s      <li><a epub:type=\"%s\" href=\"%s\">%s</a>", \
		indent(level+1), etAbbr[$4], $2 anchor, $6
	prev = level
}

END {
	for ( i = prev; i >= 0; i-- ) {
		print indent(i) "      </li>"
		if ( i > 0 )
			print indent(i) "      </ol>"
	}
	print "      </ol>"
}


